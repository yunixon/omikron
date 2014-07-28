class ChangeColumnFromEventTypes < ActiveRecord::Migration
  def change
    change_table :event_types do |t|
      t.rename :descrition, :description
    end
  end
end
