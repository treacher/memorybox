class RemoveDefaultValueForEntryDescription < ActiveRecord::Migration
  def up
  	change_column :entries, :description, :string, default: nil
  end

  def down
  	change_column :entries, :description, :string, default: "Untitled"
  end
end
