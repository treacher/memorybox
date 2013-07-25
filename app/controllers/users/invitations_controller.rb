class Users::InvitationsController < Devise::InvitationsController
   private
   def resource_params
     params.permit(user: [:first_name,:last_name, :email,:invitation_token, :your_params_here])[:user]
   end
end