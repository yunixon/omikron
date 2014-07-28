class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.decimal :sum
      t.integer :side_bet
      t.boolean :complete
      t.integer :complete_type

      t.timestamps
    end
  end
end
