class RenameAlbumIdToMemoryBoxId < ActiveRecord::Migration
  def change
  	rename_column :entries, :album_id, :memory_box_id
  end
end
