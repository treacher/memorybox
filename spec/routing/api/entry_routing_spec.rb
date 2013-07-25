require 'spec_helper'

describe Api::EntriesController do
	it "should route /api/user/memory_boxes/1/entries to api/entries#create" do
	  post("/api/user/memory_boxes/1/entries").should route_to("api/entries#create", memory_box_id: "1")
	end

	it "should route /api/user/memory_boxes/1/entries to api/entries#index" do
	  get("/api/user/memory_boxes/1/entries").should route_to("api/entries#index", memory_box_id: "1")
	end

	it "should route /api/user/memory_boxes/1/entries/1 to api/entries#destroy" do
	  delete("/api/user/memory_boxes/1/entries/1").should route_to("api/entries#destroy", memory_box_id: "1", id: "1")
	end

	it "should route /api/user/memory_boxes/1/entries/1 to api/entries#update" do
	  put("/api/user/memory_boxes/1/entries/1").should route_to("api/entries#update", memory_box_id: "1", id: "1")
	end
end