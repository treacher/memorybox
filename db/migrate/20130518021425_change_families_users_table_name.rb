class ChangeFamiliesUsersTableName < ActiveRecord::Migration
  def change
  	rename_table :families_users, :family_users
  	add_column :family_users, :id, :primary_key
  end
end
