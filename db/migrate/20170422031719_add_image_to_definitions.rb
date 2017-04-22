class AddImageToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :image, :string
  end
end
