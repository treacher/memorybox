class AddUserPusherId < ActiveRecord::Migration
  def change
  	add_column :users, :pusher_id, :string
  end
end
