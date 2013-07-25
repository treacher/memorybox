require 'spec_helper'

describe MemoryBox do
  let(:user) { FactoryGirl.create(:user) }
	let(:memory_box) { user.memory_boxes.create(title: "box") }
  let(:entry) { memory_box.entries.create(description: "desc", 
                                          media_url: "url", 
                                          media_identifier: "1", 
                                          media_format: "jpg", 
                                          media_type: "Image")}

  describe "relationships" do
  	it "has many memories" do
  	  memory_box.should respond_to(:entries)
  	end

    it "has many users" do
      memory_box.should respond_to(:users)
    end
  end

  describe "destroy dependancies" do
    before { entry }

    it "should destroy the entries in the memory box" do
      memory_box.destroy
      expect { Entry.find(entry.id) }.to raise_error
    end

    it "should destroy the member relation when you destroy the memory box" do
      Member.all.count.should eq 1
      memory_box.destroy
      Member.all.count.should eq 0
    end

    it "should destroy any invitations associated with the memory box" do
      second_user = FactoryGirl.create(:user, email:"test@test.com")
      invitation = user.sent_invitations.create(memory_box_id: memory_box.id, receiver_id: second_user.id)
      memory_box.destroy
      expect { Invitation.find(invitation.id) }.to raise_error
    end
  end

  describe "#create_entry!" do
    it "should create an entry with the attributes" do
      attributes =  { 
                      "description" => "description", 
                      "media_url" => "http://goog.gle/1", 
                      "media_identifier" => "1", 
                      "media_format" => "jpg",
                      "media_type" => "image"
                    }
      memory_box.create_entry!(attributes)
      memory_box.entries.count.should eq 1
    end
	end

  describe "#find_entry" do
    it "should find the entry" do
      memory_box.find_entry(entry.id.to_s).should eq entry
    end
  end

  describe "#delete_entry!" do
    before { entry }

    it "should delete the albums entry" do
      memory_box.entries.count.should eq 1
      memory_box.delete_entry!(entry.id)
      memory_box.entries.count.should eq 0
    end
  end

  describe "#update_entry!" do
    before { entry }
    it "should update the attributes of an entry" do
      memory_box.update_entry!(entry.id, {"description" => "new description"})
      entry.reload.description.should eq "new description"
    end
  end

  describe "#owner" do
    it "should get the owner of the memory box" do
      memory_box.members.first.update_attribute(:role, "Owner")
      memory_box.owner.should eq user
    end
  end
  
  #CHANGE - Once we have video in place
  describe "#preview_image" do
    context "has entry" do
      before {entry}

      it "should return the media url of the first entry" do
        memory_box.preview_image.should eq "url"
      end
    end

    context "no entry" do
      it "should return /assets/no-image.png if there is no entries" do
        memory_box.preview_image.should eq "https://cloudinary-a.akamaihd.net/dkgapy5l4/image/upload/v1369972482/no_image_izoyy4.jpg"
      end
    end
  end
end
