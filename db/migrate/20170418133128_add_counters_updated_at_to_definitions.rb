class AddCountersUpdatedAtToDefinitions < ActiveRecord::Migration[5.0]
  def change
    add_column :definitions, :counters_updated_at, :datetime, default: Time.now
    add_index :definitions, :counters_updated_at
  end
end
