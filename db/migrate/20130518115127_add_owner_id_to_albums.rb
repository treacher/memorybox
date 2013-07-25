class AddOwnerIdToAlbums < ActiveRecord::Migration
  def change
  	add_column :albums, :owner_id, :integer, unsigned: true
  	add_index :albums, :owner_id
  end
end
