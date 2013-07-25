require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user, email: "bill@bob.com") }

  describe "#create_memory_box!" do
    it "should create a memory_box" do
      user.create_memory_box!({title: "Jenna"})
      user.memory_boxes.count.should eq 1
      user.memory_boxes.first.title.should eq "Jenna"
    end

    it "should set the members role to 'Owner'" do
      memory_box = user.create_memory_box!({title: "Bob"})
      memory_box.members.find_by_user_id(user.id).role.should eq "Owner"
    end
  end

  context "memory box exists" do
    let!(:memory_box) { user.create_memory_box!({title: "Jensons"}) }
    let(:shared_memory_box) { FactoryGirl.create(:memory_box, title: "shared") }

    describe "#find_memory_box" do
      it "finds the memory_box" do
        user.find_memory_box(memory_box.id).should eq memory_box
      end
    end

    describe "#owned_memory_boxes" do
      before { user.memory_boxes << shared_memory_box }
      
      it "should return all the memory_boxes you are the owner of" do
        user.owned_memory_boxes.should include(memory_box)
      end

      it "should not contain any nil values" do
        user.owned_memory_boxes.should_not include(nil)
      end

      it "should not return shared memory boxes" do
        
        user.owned_memory_boxes.should_not include(shared_memory_box)
      end
    end

    describe "#shared_memory_boxes" do
      it "should not return the memory_boxes you are the owner of" do
        user.shared_memory_boxes.should_not include(memory_box)
      end
      
      it "should not return shared memory boxes" do
        user.memory_boxes << shared_memory_box
        user.shared_memory_boxes.should include(shared_memory_box)
      end
    end

    describe "#leave_memory_box!" do

      before do
        second_user.memory_boxes << memory_box
        second_user.leave_memory_box!(memory_box.id)
      end

      it "should remove the memory box from your list of memory boxes" do
        second_user.memory_boxes.reload.should_not include(memory_box)
      end

      it "should not destroy the memory box" do
        MemoryBox.find(memory_box.id).should eq memory_box
      end
    end

    describe "#delete_memory_box!" do
      before do 
        memory_box
      end

      it "deletes the memory_box" do
        user.delete_memory_box!(memory_box.id)
        user.memory_boxes.count.should eq 0
      end

      it "destroys the member relation" do
        user.delete_memory_box!(memory_box.id)
        Member.all.count.should eq 0
      end

      context "memory box deletes invitations" do
        before do
          user.stub(:find_memory_box) { memory_box }
          memory_box.stub(:destroy)
        end

        after do
          user.delete_memory_box!(memory_box.id)
        end

        it "sends a push message out to all the receivers of invitations that the memory box has been deleted" do
          invitation = mock(:invitation, receiver: second_user)
          memory_box.stub(:invitations) { [invitation]  }
          second_user.should_receive(:push_delete_invitation).with(invitation)
        end

        it "handles nil receivers when memory box is deleted" do
          invitation = mock(:invitation, receiver: nil)
          memory_box.stub(:invitations) { [invitation] }
        end
      end
    end

    describe "update_memory_box!" do
      it "updates the memory_box" do
        user.update_memory_box!(memory_box.id, {title: "Bonnie"})
        memory_box.reload.title.should eq "Bonnie"
      end
    end

    describe "#admin?" do
      before { memory_box }

      it "returns false for a nil role" do
        member = memory_box.members.find_by_user_id(user.id)
        member.update_attribute(:role, nil)
        user.admin?(memory_box.id).should be_false
      end

      it "returns true for 'Owner' role" do
        user.admin?(memory_box.id).should be_true
      end
    end
  end
end