class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :bet_id
      t.boolean :complete, default: false
      t.decimal :amount
      t.integer :t_type, default: 0
      t.integer :complete_type, default: 0

      t.timestamps
    end
  end
end
