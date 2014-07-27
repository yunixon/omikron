class ChangeColumnsFromEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.rename :event_type, :event_type_id
      t.rename :complete_type, :complete_type_id
    end
  end
end
