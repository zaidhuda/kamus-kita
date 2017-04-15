class CreateDefinitions < ActiveRecord::Migration[5.0]
  def change
    create_table :definitions do |t|
      t.references :user, foreign_key: true
      t.references :word, foreign_key: true
      t.text :definition
      t.text :example

      t.timestamps
    end
  end
end
