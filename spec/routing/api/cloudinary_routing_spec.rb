require 'spec_helper'

describe Api::CloudinaryController do

	it "should route /api/cloudinary to api/cloudinary#index" do
	  get("api/user/cloudinary").should route_to("api/cloudinary#index")
	end
end