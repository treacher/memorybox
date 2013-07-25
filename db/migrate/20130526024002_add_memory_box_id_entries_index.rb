class AddMemoryBoxIdEntriesIndex < ActiveRecord::Migration
  def up
  	add_index :entries, :memory_box_id
  end
  def down
  	remove_index :entries, :memory_box_id
  end
end
