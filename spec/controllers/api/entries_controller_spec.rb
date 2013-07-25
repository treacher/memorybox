require 'spec_helper'

describe Api::EntriesController do

	let(:user) {FactoryGirl.create(:user) }
	let(:memory_box) {user.memory_boxes.create(title: "box")}
	let(:entry) { FactoryGirl.create(:entry) }

	before do
		sign_in :user, user
		controller.current_user.should_receive(:find_memory_box) { memory_box }
	end

	describe "GET index" do
		it "should get all the entries for a users memory_box" do
		  memory_box.should_receive(:entries){[entry]}
		  get :index, memory_box_id: memory_box.id
		  assigns(:entries).should eq [entry]
		end
	end

	describe "GET show" do
		it "should get a entry from a familys memory_box" do
		  memory_box.should_receive(:find_entry) { entry }
		  get :show, memory_box_id: memory_box.id, id: entry.id
		  assigns(:entry).should eq entry
		end
	end
	context "is admin" do
		before { controller.stub(:admin?) { true } }
		describe "POST create" do
			it "should create a new entry" do
		  entry_attributes =  { 
				              "description" => "description", 
				              "media_url" => "http://goog.gle/1", 
				              "media_identifier" => "1", 
				              "media_format" => "jpg",
				              "media_type" => "image"
		          			}
			  memory_box.should_receive(:create_entry!).with(entry_attributes) { entry }
			  post :create, memory_box_id: memory_box.id, entry: entry_attributes
			  assigns(:entry).should eq entry
			end
		end

		describe "DELETE destroy" do
			it "should delete the entry" do
			  memory_box.should_receive(:delete_entry!).with(entry.id.to_s) { entry }
			  delete :destroy, memory_box_id: memory_box.id, id: entry.id
			  assigns(:entry).should eq entry
			end
		end

		describe "PUT update" do
			it "should update the entry" do
			  memory_box.should_receive(:update_entry!).with(entry.id.to_s, {"description" => "hi"}) { entry }
				put :update, memory_box_id: memory_box.id, id: entry.id, entry: { description: "hi" }
				assigns(:entry).should eq entry
			end
		end
	end
end