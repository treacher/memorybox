class AddDeletedAtToModels < ActiveRecord::Migration
  def change
  	add_column :users, :deleted_at, :datetime
  	add_column :albums, :deleted_at, :datetime
  	add_column :entries, :deleted_at, :datetime
  	add_column :families, :deleted_at, :datetime
  	add_column :family_users, :deleted_at, :datetime
  end
end