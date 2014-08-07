class ChangeCountEvents < ActiveRecord::Migration
  def up
    change_table :events do |t|
      t.change :count, :string, default: "0-0"
    end
  end
 
  def down
    change_table :events do |t|
      t.change :count, :string
    end
  end
end
