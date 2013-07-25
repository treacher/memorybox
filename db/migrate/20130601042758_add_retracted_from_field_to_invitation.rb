class AddRetractedFromFieldToInvitation < ActiveRecord::Migration
  def change
  	add_column :invitations, :retracted_from, :string
  end
end
