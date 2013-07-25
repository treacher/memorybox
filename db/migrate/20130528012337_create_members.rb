class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.integer :user_id, unsigned: true
    	t.integer :memory_box_id, unsigned: true
      t.timestamps
    end
  end
end
