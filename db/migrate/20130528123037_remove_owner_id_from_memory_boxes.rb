class RemoveOwnerIdFromMemoryBoxes < ActiveRecord::Migration
  def up
  	remove_column :memory_boxes, :owner_id
  end

  def down
  	add_column :memory_boxes, :owner_id, :integer, unsigned: true
  end
end
