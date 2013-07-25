require 'spec_helper'

describe Api::MemoryBoxesController do
	let(:user) { FactoryGirl.create(:user) }
	let(:memory_box) { user.memory_boxes.create(title:"Jenson") }

	before { sign_in :user, user }

	describe "before_filter: require_admin" do
		context "not admin" do
			it "should set the flash error & redirect to root path" do
			  delete :destroy, id: memory_box.id
			  response.body.should eq("{\"error\":\"You don't have permission to do that!\"}")
			end
		end
	end

	describe "POST create" do
		it "should create a memory box for the user" do
		  controller.current_user.should_receive(:create_memory_box!).with("title" => "Jensons") { memory_box }
		  post :create, memory_box: {title: "Jensons"}
		  assigns(:memory_box).should eq memory_box
		end
	end

	describe "GET index" do
		it "should get all the users memory_boxes" do
			controller.current_user.should_receive(:owned_memory_boxes) {[memory_box]}
			get :index
			assigns(:memory_boxes).should eq [memory_box]
		end

		it "should respond to the relationship param" do
		  controller.current_user.should_receive(:shared_memory_boxes) {[memory_box]}
		  get :index, relationship: "shared"
		  assigns(:memory_boxes) { [memory_box] }
		end
	end

	describe "GET show" do
		it "should get a users memory_box" do
		  controller.current_user.should_receive(:find_memory_box).with("1") { memory_box }
		  get :show, id: 1
		  assigns(:memory_box).should eq memory_box
		end
	end

	describe "DELETE leave_memory_box" do
		it "should leave the memory box" do
		  controller.current_user.should_receive(:leave_memory_box!).with("1")
		  delete :leave_memory_box, memory_box_id: 1
		end
	end

	context "admin" do
		before { controller.stub(:admin?) { true } }

		describe "DELETE destroy" do
			it "should delete the memory_box" do
				controller.current_user.should_receive(:delete_memory_box!).with("1") { memory_box }
			  delete :destroy, id: 1
			  assigns(:memory_box).should eq memory_box
			end
		end

		describe "PUT update" do
			it "should update the memory_box" do
			  controller.current_user.should_receive(:update_memory_box!).with("1", { "title" => "Billy"} ) { memory_box }
			  put :update, id: 1, memory_box: {title: "Billy"}
			  assigns(:memory_box).should eq memory_box
			end
		end
	end
end