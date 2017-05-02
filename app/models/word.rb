class Word < ApplicationRecord
  extend FriendlyId
  friendly_id :word, use: :slugged
  has_many :definitions
  has_one :best_definition, -> { order(likes_counter: :desc).limit(1) }, class_name: 'Definition'
  
  mount_uploader :banner, ImageUploader

  validates_presence_of :word
  validates_length_of :word, maximum: 50

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

  def generate_banner
    html = ImageController.new.render_to_string(template: 'image/banner',
      locals: {
        root_url: Rails.application.routes.url_helpers.root_url,
        word: self
      })
    kit = IMGKit.new(html.html_safe, quality: 70)
    filename = "#{Rails.root.join}/tmp/#{Digest::MD5.hexdigest(original_word)}.png"
    temp_file = kit.to_file(filename)
    self.banner = temp_file
    self.save
  end
end
