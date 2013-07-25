class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :description
      t.string :media_url
      t.string :media_identifier
      t.string :media_format
      t.string :media_type
      t.integer :album_id
      t.timestamps
    end
  end
end