class RenameAlbumToMemoryBox < ActiveRecord::Migration
  def change
  	rename_table :albums, :memory_boxes
  end
end
