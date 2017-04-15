class Word < ApplicationRecord
  extend FriendlyId
  friendly_id :word, use: :slugged
  has_many :definitions

  validates_presence_of :word

  def destroy
    self.update_attribute(:hidden, true)
  end
end
