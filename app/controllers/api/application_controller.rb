class Api::ApplicationController < ApplicationController

	before_filter :authenticate_user!

	skip_before_filter  :verify_authenticity_token
	respond_to :json

	def require_admin
		unless admin?
			render json: {error: "You don't have permission to do that!"}
		end
	end
end