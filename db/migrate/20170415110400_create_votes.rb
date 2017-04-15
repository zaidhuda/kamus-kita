class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :definition, foreign_key: true
      t.boolean :like

      t.timestamps
    end

    add_index :votes, [:definition_id, :like]
  end
end
