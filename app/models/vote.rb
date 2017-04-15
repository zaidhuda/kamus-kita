class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :definition

  after_commit :update_definition_votes_cache

  private

  def update_definition_votes_cache
    definition.update_columns(
         likes_counter: Vote.where(definition_id: definition_id, like: true).ids.size,
      dislikes_counter: Vote.where(definition_id: definition_id, like: false).ids.size
    )
  end
end
