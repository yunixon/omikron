class AddResultToCompleteTypes < ActiveRecord::Migration
  def change
    add_column :complete_types, :result, :integer
  end
end
