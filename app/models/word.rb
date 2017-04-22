class Word < ApplicationRecord
  extend FriendlyId
  friendly_id :word, use: :slugged
  has_many :definitions
  has_one :best_definition, -> { order(likes_counter: :desc).limit(1) }, class_name: 'Definition'

  validates_presence_of :word
  validates_length_of :word, maximum: 50

  def destroy
    self.update_attribute(:hidden, true)
  end

  def should_generate_new_friendly_id?
    true if word_changed?
  end
end
