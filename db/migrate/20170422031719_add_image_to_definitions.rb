class AddImageToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :image, :string
    add_column :definitions, :image_generated_at, :datetime
  end
end
