class AddHandleAndSlugToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :handle, :string
    add_column :users, :slug, :citext
    add_index :users, :slug
  end
end
