class Api::CloudinaryController < Api::ApplicationController
	def index
		timestamp = Time.now.to_i
		transformation = "a_exif,fl_progressive" 
		signature = Cloudinary.generate_signature_with_transformation(timestamp,transformation)
		render json: { 
			url: "http://api.cloudinary.com/v1_1/dkgapy5l4/image/upload?api_key=#{CLOUDINARY_PUBLIC_KEY}&timestamp=#{timestamp}&transformation=#{transformation}&signature=#{signature}" 
		}
	end
end