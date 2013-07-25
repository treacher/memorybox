class RemoveDeletedAtAddDeletedBoolean < ActiveRecord::Migration
  def up
  	remove_column :memory_boxes, :deleted_at
  	remove_column :entries, :deleted_at
  	add_column :memory_boxes, :deleted, :boolean
  	add_column :entries, :deleted, :boolean
  end

  def down
  	add_column :memory_boxes, :deleted_at, :datetime
  	add_column :entries, :deleted_at, :datetime
  	remove_column :memory_boxes, :deleted
  	remove_column :entries, :deleted
  end
end
