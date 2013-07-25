class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
    	t.string :title
      t.timestamps
    end
    add_column :albums, :family_id, :integer, unsigned: true
    add_index :albums, :family_id
  end
end
