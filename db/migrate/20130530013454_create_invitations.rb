class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
    	t.string :status, default: "pending"
    	t.integer :receiver_id, unsigned: true
      t.integer :sender_id, unsigned: true
    	t.integer :memory_box_id, unsigned: true
      t.timestamps
    end
    
    add_index :invitations, :status
    add_index :invitations, :receiver_id
    add_index :invitations, :sender_id
    add_index :invitations, :memory_box_id
  end
end
