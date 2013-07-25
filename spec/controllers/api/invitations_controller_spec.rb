require 'spec_helper'

describe Api::InvitationsController do

	let(:user) { FactoryGirl.create(:user) }
	let(:receiver) { FactoryGirl.create(:user, email: "jill@joe.com") }
	let(:memory_box) { user.memory_boxes.create(title:"Jenson") }
	let(:invitation) { FactoryGirl.create(:invitation, receiver_id: receiver.id, sender_id: user.id, memory_box_id: memory_box.id) }

	before { sign_in :user, user }

	context "is admin" do
		before { controller.stub(:admin?) { true }}

		describe "POST create" do
			it "should invite the users to the memory box and render a success message." do
			  controller.current_user.should_receive(:invite_to_memory_box).with(memory_box.id.to_s, "bill@bob.com, james@jill.com", "message") { true }
			  post :create, memory_box_id: memory_box.id, invitations: "bill@bob.com, james@jill.com", message: "message"
			  response.body.should eq("{\"success\":\"Invitations sent!\"}")
			end
		end
	end

	describe "put retract" do
		it "should retract the invitation" do
			controller.current_user.should_receive(:retract_invitation).with("1") { invitation }
			put :retract, invitation_id: 1
			assigns(:invitation).should eq invitation
		end
	end

	describe "put accept" do
		it "should accept the invitation" do
		  controller.current_user.should_receive(:accept_box_invitation).with("1") { invitation }
		  put :accept, invitation_id: 1
		  assigns(:invitation).should eq invitation
		end
	end

	describe "put decline" do
		it "should decline the invitation" do
		  controller.current_user.should_receive(:decline_invitation).with("1") { invitation }
		  put :decline, invitation_id: 1
		  assigns(:invitation).should eq invitation
		end
	end

	describe "GET received_invitations" do
		it "should get the current users received_invitations" do
		  controller.current_user.should_receive(:received_invitations) { [invitation] }
		  get :received_invitations
		  assigns(:received_invitations).should eq [invitation]
		end
	end

	describe "GET sent_invitations" do
		it "should get the current users sent_invitations" do
		  controller.current_user.should_receive(:sent_invitations) { [invitation] }
		  get :sent_invitations
		  assigns(:sent_invitations).should eq [invitation]
		end
	end
end