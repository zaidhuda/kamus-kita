class Definition < ApplicationRecord
  belongs_to :user
  belongs_to :word
  has_many :votes

  mount_uploader :image, ImageUploader

  before_validation :find_or_create_word

  validates_presence_of :user_id, :word_id, :original_word, :definition, :example

  def self.votes
    self.select("user_id, SUM(likes_counter) as likes, SUM(dislikes_counter) as dislikes").group(:user_id)[0]
  end

  def find_or_create_word
    if new_record?
      self.word = Word.friendly.find(original_word.downcase.parameterize)
    end
  rescue ActiveRecord::RecordNotFound
    self.word = Word.create!(word: original_word)
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
end
