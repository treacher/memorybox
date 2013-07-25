require 'spec_helper'

describe Api::InvitationsController do
	it "should route /api/user/memory_boxes/1/entries to api/entries#create" do
	  post("/api/user/memory_boxes/1/invitations").should route_to("api/invitations#create", memory_box_id: "1")
	end

	it "should route /api/user/invitations/accept to api/invitations#accept" do
	  put("/api/user/invitations/1/accept").should route_to("api/invitations#accept", invitation_id: "1")
	end

	it "should route /api/user/invitations/decline to api/invitations#decline" do
	  put("/api/user/invitations/1/decline").should route_to("api/invitations#decline", invitation_id: "1")
	end
	it "should route /api/user/invitations/retract to api/invitations#retract" do
	  put("/api/user/invitations/1/retract").should route_to("api/invitations#retract", invitation_id: "1")
	end

	it "should route /api/user/invitations/received_invitations to api/invitations#received_invitations" do
	  get("/api/user/invitations/received_invitations").should route_to("api/invitations#received_invitations")
	end

	it "should route /api/user/invitations/sent_invitations to api/invitations#sent_invitations" do
	  get("/api/user/invitations/sent_invitations").should route_to("api/invitations#sent_invitations")
	end
end