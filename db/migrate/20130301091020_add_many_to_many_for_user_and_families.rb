class AddManyToManyForUserAndFamilies < ActiveRecord::Migration
def change
		create_table :families_users, :id => false do |t|
		  t.integer :user_id
		  t.integer :family_id
		end
		add_index :families_users, :user_id
		add_index :families_users, :family_id
	end
end
