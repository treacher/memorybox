class ChangeEntriesDefaultDescription < ActiveRecord::Migration
  def change
  	change_column :entries, :description, :string, default: "Untitled"
  end
end
