class ChangeUsersBalance < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :balance, :decimal, default: 0
    end
  end
 
  def down
    change_table :users do |t|
      t.change :balance, :decimal
    end
  end
end
