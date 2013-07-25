require 'spec_helper'

describe Invitation do

	let(:sender) { FactoryGirl.create(:user, email: "sender@send.com") }
	let(:receiver) { FactoryGirl.create(:user, email: "receiver@send.com") }
	let(:memory_box) { sender.memory_boxes.create(title: "Bob") }
	let(:invitation) { FactoryGirl.create(:invitation, receiver_id: receiver.id, sender_id: sender.id, memory_box_id: memory_box.id) }
	let(:memory_box_2) { sender.memory_boxes.create(title: "Bill") }

	describe "after:save" do
		let(:mailer) { mock(:mailer) }

		before { ActionMailer::Base.deliveries.clear }

		it "should send an email notifying the user that is receiving the invitation" do
		  sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  ActionMailer::Base.deliveries.count.should eq 1
		end
	end

	describe "after:save" do
		before { ActionMailer::Base.deliveries.clear }
		it "should resent the invitation email if the status is set back to pending." do
		  sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  invitation = sender.sent_invitations.last
		  invitation.save
		  ActionMailer::Base.deliveries.count.should eq 2
		end
	end

	describe "pending?" do
		it "should return true if the status is pending." do
		  invitation.pending?.should be_true
		end

		it "should return false if the status is accepted" do
		  invitation.status = "accepted"
		  invitation.pending?.should be_false
		end
	end
	
	describe "relationships" do
		it "should have a receiver" do
		  invitation.should respond_to(:receiver)
		end

		it "should have a memory_box" do
		  invitation.should respond_to(:memory_box)
		end

		it "should have a sender" do
		  invitation.should respond_to(:sender)
		end
	end

	describe "defaults" do
		it "should default status to 'pending'" do
		  invitation.status.should eq 'pending'
		end
	end

	describe "validations" do
		it "validates the presence of sender_id" do
		  invitation.sender_id = nil
		  invitation.valid?.should be_false
		end

		it "validates the presence of memory_box_id" do
		  invitation.memory_box_id = nil
		  invitation.valid?.should be_false
		end

		it "validates that you can send invitations for different memory boxes from the same user to the same user" do
		  sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  invitation = sender.sent_invitations.new(receiver_id: receiver.id, memory_box_id: memory_box_2.id)
		  invitation.valid?.should be_true
		end

		it "validates that you can only send one invitation to a user for a given memory box if the invitation is pending" do
		  sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  invitation = sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  invitation.valid?.should be_false
		end

		it "You can send a new invitation if the old one was declined" do
		  sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  invitation = sender.sent_invitations.create(receiver_id: receiver.id, memory_box_id: memory_box.id)
		  invitation.status = "declined"
		  invitation.valid?.should be_true
		end
	end
end
