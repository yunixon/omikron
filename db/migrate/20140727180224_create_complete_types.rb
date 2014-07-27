class CreateCompleteTypes < ActiveRecord::Migration
  def change
    create_table :complete_types do |t|
      t.string :result
      t.text :description

      t.timestamps
    end
  end
end
