class CreateWords < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'

    create_table :words do |t|
      t.string :word, unique: true, index: true
      t.citext :slug, unique: true, index: true

      t.timestamps
    end
  end
end
