class Cloudinary
	class << self
		def generate_signature(timestamp)
			Digest::SHA1.hexdigest "timestamp=#{timestamp}#{ENV['CLOUDINARY_SECRET_KEY']}"
		end

		def generate_signature_with_transformation(timestamp, transformation)
			Digest::SHA1.hexdigest "timestamp=#{timestamp}&transformation=#{transformation}#{ENV['CLOUDINARY_SECRET_KEY']}"
		end

		def generate_signature_for_deletion(timestamp, public_id)
			Digest::SHA1.hexdigest "public_id=#{public_id}&timestamp=#{timestamp}#{ENV['CLOUDINARY_SECRET_KEY']}"
		end

		def generate_params_for_deletion(public_id)
			timestamp = Time.now.to_i
			"api_key=#{ENV['CLOUDINARY_PUBLIC_KEY']}&public_id=#{public_id}&timestamp=#{timestamp}&signature=#{generate_signature_for_deletion(timestamp, public_id)}"
		end
	end
end