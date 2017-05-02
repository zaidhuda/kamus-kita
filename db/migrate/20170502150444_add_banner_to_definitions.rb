class AddBannerToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :banner, :string
  end
end
