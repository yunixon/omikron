class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :event_type
      t.string :first_side
      t.string :string
      t.string :second_side
      t.datetime :datetime_start
      t.boolean :complete
      t.string :count
      t.integer :complete_type

      t.timestamps
    end
  end
end
