class AddHiddenToWordsAndDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :hidden, :boolean, default: false
    add_column :definitions, :hidden, :boolean, default: false
    add_index :words, :hidden
    add_index :definitions, :hidden
  end
end
