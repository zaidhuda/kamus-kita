class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :definition

  after_commit :update_definition_votes_cache

  private

  def update_definition_votes_cache
    definition.update_counters
  end
end
