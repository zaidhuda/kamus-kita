class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :definition

  validates_presence_of :user_id, :definition_id
end
