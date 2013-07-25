ActiveAdmin.register User do
	filter :email
	filter :first_name
	filter :last_name

	index do
    column :first_name
    column :last_name
    column :email
    actions
  end

	form do |f|
    f.inputs "Details" do
	    f.input :first_name
	    f.input :last_name
	    f.input :email
	  end
	  f.actions
	end

  controller do
  	def permitted_params
  		params.permit(user: [:first_name, :last_name, :email])
  	end
  end
end
