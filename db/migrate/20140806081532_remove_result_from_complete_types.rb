class RemoveResultFromCompleteTypes < ActiveRecord::Migration
  def change
    remove_column :complete_types, :result, :string
  end
end
