require "spec_helper"

describe InvitationMailer do
	let(:inviter) { mock(:user, first_name: "Bill", last_name: "jon", email: "inviter@bob.com") }
	let(:invited) { mock(:user, first_name: "bob", last_name: "jon", email: "invited@bob.com") }
  let(:invitation) { mock(:invitation, receiver: invited, sender: inviter, message: "Hello!") }
  let(:memory_box) { mock(:memory_box, id: 1, title: "He") }

  describe "#welcome_email" do
  	it "sets the emails 'to' to the inviteds email address " do
  		email = InvitationMailer.existing_user_memory_box_invitation(invitation, memory_box)
  		email.to.should include(invited.email)
  	end

  	it "sets the subject" do
  	  email = InvitationMailer.existing_user_memory_box_invitation(invitation, memory_box)
  	  email.subject.should eq "MemoryBox - Bill has invited you to a MemoryBox."
  	end
  end
end