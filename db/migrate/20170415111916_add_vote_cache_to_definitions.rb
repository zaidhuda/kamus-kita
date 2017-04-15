class AddVoteCacheToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :likes_counter, :integer, default: 0, null: false
    add_column :definitions, :dislikes_counter, :integer, default: 0, null: false

    add_index :definitions, [:word_id, :likes_counter]
    add_index :definitions, [:word_id, :dislikes_counter]
  end
end
