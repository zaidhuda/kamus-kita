class AddTagsToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :tags, :string
  end
end
