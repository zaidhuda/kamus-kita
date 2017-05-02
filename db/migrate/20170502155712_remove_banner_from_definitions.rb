class RemoveBannerFromDefinitions < ActiveRecord::Migration[5.0]
  def change
    remove_column :definitions, :banner, :string
  end
end
