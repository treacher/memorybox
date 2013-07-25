class AddIndexesToJoinTable < ActiveRecord::Migration
  def change
  	add_index :members, :memory_box_id
  	add_index :members, :user_id
  end
end
