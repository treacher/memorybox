require 'spec_helper'

describe Member do
	describe "validations" do
		let!(:user) { FactoryGirl.create(:user) }
		let!(:memory_box) { user.memory_boxes.create(title: "Bob") }

		it "validates a user can only have a memory box once" do
		  Member.count.should eq 1
		  member = Member.new(user_id: user.id, memory_box_id: memory_box.id)
		  member.valid?.should be_false
		end
	end
end
