class Word < ApplicationRecord
  extend FriendlyId
  friendly_id :word, use: :slugged
  has_many :definitions
  has_one :best_definition, -> { order(likes_counter: :desc).limit(1) }, class_name: 'Definition'
  
  mount_uploader :banner, BannerUploader

  validates_presence_of :word
  validates_length_of :word, maximum: 50

  after_create :tweet_banner
  after_create :run_banner_generator_job

  def destroy
    self.update_attribute(:hidden, true)
  end

  def should_generate_new_friendly_id?
    true if word_changed?
  end

  def run_banner_generator_job
    GenerateBannerJob.perform_async(id)
  end

  def tweet_banner
    $twitter.update "#{word} #kamuskita #{Rails.application.routes.url_helpers.word_url(self)}"
  end

  def generate_banner
    kit = IMGKit.new(Rails.application.routes.url_helpers.banner_template_word_url(self), quality: 70)
    filename = "#{Rails.root.join}/tmp/#{Digest::MD5.hexdigest(word)}.png"
    self.banner = kit.to_file(filename)
    self.save
  end
end
