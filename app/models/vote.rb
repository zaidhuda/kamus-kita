class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :definition

  validates_presence_of :user_id, :definition_id

  scope :likes, -> { where(like: true) }
  scope :dislikes, -> { where(like: false) }
  scope :ignores, -> { where(like: nil) }
  scope :significant, -> { where.not(like: nil) }
end
