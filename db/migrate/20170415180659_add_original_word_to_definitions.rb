class AddOriginalWordToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :original_word, :string
  end
end
