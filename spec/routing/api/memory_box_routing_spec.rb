require 'spec_helper'

describe Api::MemoryBoxesController do
	it "should route /api/user/memory_boxes to api/memory_boxes#create" do
	  post("/api/user/memory_boxes").should route_to("api/memory_boxes#create")
	end

	it "should route /api/user/memory_boxes to api/memory_boxes#index" do
	  get("/api/user/memory_boxes").should route_to("api/memory_boxes#index")
	end

	it "should route /api/user/memory_boxes/1 to api/memory_boxes#show" do
	  get("/api/user/memory_boxes/1").should route_to("api/memory_boxes#show", id: "1")
	end

	it "should route /api/user/memory_boxes/1 to api/memory_boxes#destroy" do
	  delete("/api/user/memory_boxes/1").should route_to("api/memory_boxes#destroy", id: "1")
	end

	it "should route /api/user/memory_boxes/1/leave_memory_box to api/memory_boxes#leave_memory_box" do
	  delete("/api/user/memory_boxes/1/leave_memory_box").should route_to("api/memory_boxes#leave_memory_box", memory_box_id: "1")
	end

	it "should route /api/user/memory_boxes/1 to api/memory_boxes#update" do
	  put("/api/user/memory_boxes/1").should route_to("api/memory_boxes#update", id: "1")
	end
end