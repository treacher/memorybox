require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user, email: "bill@bob.com") }
  let(:third_user) { FactoryGirl.create(:user, email: "bob@jil.com") }
  let!(:memory_box) { user.memory_boxes.create(title: "Jensons") }

  before do
    mail = mock(:mail)
    InvitationMailer.stub(:existing_user_memory_box_invitation) { mail }
    mail.stub(:deliver)
  end

  describe "#retract_invitation" do
    it "changes the state to retracted and removes the the invitation from the receivers received invitation" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.received_invitations.count.should eq 1
      user.retract_invitation(second_user.received_invitations.first.id)
      second_user.received_invitations.count.should eq 0
      user.sent_invitations.count.should eq 1
      user.sent_invitations.first.status.should eq "retracted"
      user.sent_invitations.first.retracted_from.should eq second_user.email
    end

    it "does not retract if the status is not pending" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.accept_box_invitation(second_user.received_invitations.first.id)
      user.retract_invitation(second_user.received_invitations.first.id)
      second_user.received_invitations.count.should eq 1
    end
  end

  describe "#accept_box_invitation" do
    it "changes the state to accepted and adds the memory box to the receivers memory boxes" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.received_invitations.count.should eq 1
      second_user.accept_box_invitation(second_user.received_invitations.first.id)
      second_user.memory_boxes.should include(memory_box)
      user.sent_invitations.first.status.should eq "accepted"
    end

    it "does nothing if the state is not pending" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.accept_box_invitation(second_user.received_invitations.first.id)
      second_user.decline_invitation(second_user.received_invitations.first.id)
      second_user.received_invitations.first.status.should eq "accepted"
      second_user.memory_boxes.should include(memory_box)
    end
  end

  describe "#valid_email" do

    it "returns false for m.w.treacher" do
      User.valid_email("m.w.treacher").should be_false
    end

    it "returns true for m.w.treacher@gmail.com" do
      User.valid_email("m.w.treacher@gmail.com").should be_true
    end
  end

  describe "#decline_invitation" do
    it "sets the status of the invitation to declined" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.received_invitations.count.should eq 1
      second_user.decline_invitation(second_user.received_invitations.first.id)
      second_user.memory_boxes.should_not include(memory_box)
      user.sent_invitations.first.status.should eq "declined"
    end

    it "does nothing if the state is not pending" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.decline_invitation(second_user.received_invitations.first.id)
      second_user.accept_box_invitation(second_user.received_invitations.first.id)
      second_user.received_invitations.first.status.should eq "declined"
      second_user.memory_boxes.should_not include(memory_box)
    end
  end

  describe "#invite_to_memory_box" do

    before do
      memory_box
    end

    it "downcases all of the email addressed before it validates the emails" do
      User.should_receive(:valid_email).with("m.w.treacher@gmail.com")
      User.should_receive(:valid_email).with("meegz_is@hotmail.com")
      user.invite_to_memory_box(memory_box.id, "M.W.Treacher@gmail.com, Meegz_IS@hotmail.com")
    end

    context "old invitation" do
      it "allows the user to send the invitation again after it has been declined" do
        user.invite_to_memory_box(memory_box.id, second_user.email)
        second_user.decline_invitation(second_user.received_invitations.first.id)
        user.invite_to_memory_box(memory_box.id, second_user.email)

        second_user.received_invitations.count.should eq 1
        second_user.received_invitations.first.status.should eq "pending"
      end

      it "sets the invitations status back to pending if you send out the invitation again after somebody has left the memory box" do
        user.invite_to_memory_box(memory_box.id, second_user.email)
        second_user.accept_box_invitation(second_user.received_invitations.first.id)
        second_user.leave_memory_box!(memory_box.id)
        user.invite_to_memory_box(memory_box.id, second_user.email)
        second_user.received_invitations.first.status.should eq "pending"
      end

      it "sets the invitations message to the new message" do
        user.invite_to_memory_box(memory_box.id, second_user.email, "old message")
        second_user.received_invitations.last.message.should eq "old message"
        second_user.decline_invitation(second_user.received_invitations.first.id)
        user.invite_to_memory_box(memory_box.id, second_user.email, "new message")
        second_user.received_invitations.last.message.should eq "new message"
      end
    end

    it "finds the users and sends them an invitation" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      user.sent_invitations.should_not be_empty
      second_user.received_invitations.should_not be_empty
    end

    it "sets the message in the invitation if one is defined" do
      user.invite_to_memory_box(memory_box.id, second_user.email, "message #1")
      second_user.received_invitations.last.message.should eq "message #1"
    end

    it "accepts a comma seperated list of email addresses" do
      user.invite_to_memory_box(memory_box.id, "#{second_user.email}, #{third_user.email}")
      user.sent_invitations.count.should eq 2
      second_user.received_invitations.count.should eq 1
      third_user.received_invitations.count.should eq 1
    end

    it "does not send an invitation to somebody who has is already a member" do
      user.invite_to_memory_box(memory_box.id, "#{second_user.email}, #{third_user.email}")
      second_user.accept_box_invitation(second_user.received_invitations.first.id)
      user.invite_to_memory_box(memory_box.id, "#{second_user.email}, #{third_user.email}")
      user.sent_invitations.count.should eq 2
      second_user.received_invitations.count.should eq 1
    end

    it "invites a user to the application if they do not already exist" do
      user.invite_to_memory_box(memory_box.id, "jone@joe.com")
      user = User.find_by_email("jone@joe.com")
      user.should_not be_nil
      user.received_invitations.count.should eq 1
    end

    it "does not allow the user to send another invitation if the first has been accepted" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.accept_box_invitation(second_user.received_invitations.first.id)
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.received_invitations.first.status.should eq "accepted"
    end

    it "does not send an invitation again if there is currently one pending" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      user.invite_to_memory_box(memory_box.id, second_user.email)
      second_user.received_invitations.count.should eq 1
      second_user.received_invitations.first.status.should eq "pending"
    end

    it "reuses the correct invitation." do
      second_memory_box = user.memory_boxes.create(title: "jill")
      user.invite_to_memory_box(memory_box.id, second_user.email)
      user.invite_to_memory_box(second_memory_box.id, second_user.email)

      second_user.decline_invitation(second_user.received_invitations.where(memory_box_id: second_memory_box.id))
      second_user.decline_invitation(second_user.received_invitations.where(memory_box_id: memory_box.id))

      user.invite_to_memory_box(second_memory_box.id, second_user.email)
      
      second_user.received_invitations.where(memory_box_id: second_memory_box.id).first.status.should eq "pending"
    end

    it "creates a new invitation if an invitation is retracted" do
      user.invite_to_memory_box(memory_box.id, second_user.email)
      user.retract_invitation(user.sent_invitations.first.id)
      user.invite_to_memory_box(memory_box.id, second_user.email)

      user.sent_invitations.count.should eq 2
      second_user.received_invitations.count.should eq 1
    end

    it "handles invalid emails" do
      user.invite_to_memory_box(memory_box.id, "m.w.treacher")
      user.sent_invitations.count.should eq 0
    end
  end
end