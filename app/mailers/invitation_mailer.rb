class InvitationMailer < ActionMailer::Base
  default from: "mailer@memoryboxapp.com"

  def existing_user_memory_box_invitation(invitation, memory_box)
  	@inviting_user = invitation.sender
  	@invited_user = invitation.receiver
  	@message = invitation.message
  	@memory_box = memory_box
  	mail(to: @invited_user.email, subject: "MemoryBox - #{@inviting_user.first_name} has invited you to a MemoryBox.")
  end
end
