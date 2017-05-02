class Definition < ApplicationRecord
  include PgSearch
  pg_search_scope :search_for, against: [:original_word, :definition],
    using: {trigram: { only: :original_word }, tsearch: { any_word: true }}

  belongs_to :user
  belongs_to :word
  has_many :votes

  mount_uploader :image, ImageUploader

  before_validation :find_or_create_word

  validates_presence_of :user_id, :word_id, :original_word, :definition, :example
  validates_length_of :original_word, maximum: 50

  after_commit :run_image_generator_job

  def self.votes
    self.select("user_id, SUM(likes_counter) as likes, SUM(dislikes_counter) as dislikes").group(:user_id)[0]
  end

  def find_or_create_word
    self.original_word = original_word[0..49]
    if new_record?
      self.word = Word.friendly.find(original_word.downcase.parameterize)
    end
  rescue ActiveRecord::RecordNotFound
    self.word = Word.create!(word: original_word)
  end

  def run_image_generator_job
    GenerateImageJob.perform_async(id)
  end

  def generate_image_helper
    if updated_at.to_i > image_generated_at.to_i
      generate_image
    end
  end

  def tweet_image
    if image && image.url
      $twitter.update_with_media(
        "#{original_word} #{Rails.application.routes.url_helpers.word_definition_url(word, self)}",
        open(image.url)
      )
    end
  end

  def cleaned_definition
    definition.gsub(/\[.*?\]/){ |s|
      s[1..s.size-2] if s.size > 2
    }
  end

  def liked_by liker
    vote = votes.find_or_initialize_by(user: liker)
    vote.update_attribute(:like, true)
  end

  def disliked_by disliker
    vote = votes.find_or_initialize_by(user: disliker)
    vote.update_attribute(:like, false)
  end

  def ignored_by everyone
    vote = votes.find_or_initialize_by(user: everyone)
    vote.update_attribute(:like, nil)
  end

  after_find do |definition|
    update_counters if should_update_counters?
  end

  def should_update_counters?
    counters_updated_at < 1.hour.ago
  rescue ActiveModel::MissingAttributeError
    false
  end

  def update_counters
    update_columns(
            likes_counter: votes.where(like: true).size,
         dislikes_counter: votes.where(like: false).size,
      counters_updated_at: Time.now
    )
  end

  def destroy
    self.update_attribute(:hidden, true)
  end

  def generate_image
    html = ImageController.new.render_to_string(template: 'image/new',
      locals: {
        root_url: Rails.application.routes.url_helpers.root_url,
        definition: self
      })
    kit = IMGKit.new(html.html_safe, quality: 70)
    filename = "#{Rails.root.join}/tmp/#{Digest::MD5.hexdigest(updated_at.to_s||created_at.to_s)}.png"
    temp_file = kit.to_file(filename)
    self.image = temp_file
    self.image_generated_at = Time.now
    self.save
  end
end
