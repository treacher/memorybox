class User
	module InvitationMethods
		extend ActiveSupport::Concern

	  def push_pending_invitations
	    Pusher["push-#{self.pusher_id}"].trigger('updateInvitations', {message: self.received_invitations.where(status: "pending").count}) if Rails.env.production?
	  end

	  def push_update_received_invitation(invitation)
	    Pusher["push-#{self.pusher_id}"].trigger('updateReceivedInvitation', {message: {id: invitation.id, status: invitation.status}}) if Rails.env.production?
	  end

	  def push_delete_invitation(invitation)
	    Pusher["push-#{self.pusher_id}"].trigger('deleteInvitation', {message: {id: invitation.id} }) if Rails.env.production?
	  end

	  def push_add_invitation(invitation)
	    Pusher["push-#{self.pusher_id}"].trigger('addInvitation', {message: ReceivedInvitationsSerializer.new(invitation) }) if Rails.env.production?
	  end

	  def push_update_sent_invitation(invitation)
	    Pusher["push-#{self.pusher_id}"].trigger('updateSentInvitation', {message: {id: invitation.id, status: invitation.status}}) if Rails.env.production?
	  end

		def retract_invitation(invitation_id)
		  invitation = self.sent_invitations.find(invitation_id)
		  
		  if invitation.pending?
		    invitation.retracted_from = invitation.receiver.email
		    receiver = invitation.receiver
		    invitation.status = "retracted"
		    invitation.receiver_id = nil
		    invitation.save
		    receiver.push_pending_invitations
		    receiver.push_delete_invitation(invitation)
		  end
		end

		def decline_invitation(invitation_id)
		  invitation = self.received_invitations.find(invitation_id)

		  if invitation.pending?
		    invitation.status = "declined"
		    invitation.save
		    push_pending_invitations
		    invitation.sender.push_update_sent_invitation(invitation)
		  end
		end

		def accept_box_invitation(invitation_id)
		  invitation = self.received_invitations.find(invitation_id)

		  if invitation.pending?
		    memory_boxes = self.memory_boxes
		    memory_boxes << invitation.memory_box unless memory_boxes.include?(invitation.memory_box)
		    invitation.status = "accepted"
		    invitation.save
		    push_pending_invitations
		    invitation.sender.push_update_sent_invitation(invitation)
		  end
		end

		def invite_to_memory_box(memory_box_id, users, message=nil)
		  memory_box = self.find_memory_box(memory_box_id)
		  
		  users.split(',').map(&:strip).map(&:downcase).each do |email|
		  	next unless User.valid_email(email) # skip if the email is invalid

		    user = User.find_by_email(email)
		    if user
		      invitation = self.sent_invitations.create(receiver_id: user.id, memory_box_id: memory_box_id, message: message) unless memory_box.users.include? user
		      # If it is not valid an invitation already exists. Lets change the state back to pending if it is rejected.
		      if !invitation.nil? and !invitation.valid?
		        old_invitation = self.sent_invitations.where(memory_box_id: memory_box.id, receiver_id: user.id).first
		        if old_invitation.present? and not old_invitation.pending?
		          old_invitation.update_attributes({status: "pending", message: message})
		          user.push_update_received_invitation(old_invitation)
		        end
		      else
		      	user.push_add_invitation(invitation) unless memory_box.users.include? user
		      end
		    else
		      user = User.invite!({email: email, invitation_message: message}, self)
		      self.sent_invitations.create(receiver_id: user.id, memory_box_id: memory_box_id, message: message, dont_notify_user: true)
		    end

		    user.push_pending_invitations
		  end
		end

	end
end