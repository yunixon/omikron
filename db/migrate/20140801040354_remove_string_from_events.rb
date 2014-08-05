class RemoveStringFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :string, :string
  end
end
