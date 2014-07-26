class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :user_id
      t.integer :event_id
      t.decimal :sum
      t.integer :side_bet
      t.boolean :complete
      t.integer :complete_type

      t.timestamps
    end
  end
end
