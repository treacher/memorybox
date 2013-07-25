class Invitation < ActiveRecord::Base

	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
	
	belongs_to :memory_box

	validates :sender_id, :memory_box_id, presence: true
	validates :memory_box_id, uniqueness: { scope: [:receiver_id, :sender_id], message: "Invitation for memory box already sent!" }, if: :pending? 

	after_save :notify_user, unless: -> { dont_notify_user or !pending? }

	attr_accessor :dont_notify_user

	def notify_user
		memory_box = sender.find_memory_box(memory_box_id)
		InvitationMailer.existing_user_memory_box_invitation(self, memory_box).deliver
	end

	def pending?
		self.status.try(:downcase) == "pending"
	end
end