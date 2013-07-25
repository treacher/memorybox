require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create(:user) }

  describe "relationships" do
    it "has many memory_boxes" do
      user.should respond_to(:memory_boxes)
    end

    it "has many sent_invitations" do
      user.should respond_to(:sent_invitations)
    end

    it "has many sent_invitations" do
      user.should respond_to(:received_invitations)
    end
  end

  describe "before:save" do
    it "should set the pusher_id after create" do
      user.pusher_id.should_not be_nil
    end
  end
end