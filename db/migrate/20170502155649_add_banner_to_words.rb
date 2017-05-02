class AddBannerToWords < ActiveRecord::Migration[5.0]
  def change
    add_column :words, :banner, :string
  end
end
