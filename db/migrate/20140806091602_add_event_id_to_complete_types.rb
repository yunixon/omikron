class AddEventIdToCompleteTypes < ActiveRecord::Migration
  def change
    add_column :complete_types, :event_id, :integer
  end
end
