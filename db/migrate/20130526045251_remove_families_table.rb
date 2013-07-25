class RemoveFamiliesTable < ActiveRecord::Migration
  def up
  	drop_table :families
  end

  def down
  	create_table :families do |t|
    	t.string :name
      t.timestamps
    end
  end
end
