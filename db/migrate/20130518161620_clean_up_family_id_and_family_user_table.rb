class CleanUpFamilyIdAndFamilyUserTable < ActiveRecord::Migration
  def change
  	remove_column :memory_boxes, :family_id
  	drop_table :family_users
  end
end
