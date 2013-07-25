class SentInvitationsSerializer < ActiveModel::Serializer
	attributes :id, :receivers_email, :memory_box_id, :memory_box_title, :created_at, :status

	def receivers_email
		object.receiver.present? ? object.receiver.email : object.retracted_from
	end

	def memory_box_id
		object.memory_box.try(:id)
	end

	def memory_box_title
		object.memory_box.try(:title)
	end
end