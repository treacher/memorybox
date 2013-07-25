require 'spec_helper'

describe Entry do

	let(:entry) { FactoryGirl.build(:entry) }

	context "validations" do
		[:media_url, :media_identifier, :media_format, :media_type].each do |attribute|
			it "validates that a #{attribute} is present" do
				entry.send("#{attribute}=", nil)
		  	entry.should_not be_valid
		  end
		end
	end

  context "relationships" do
  	it "belongs to a family" do
  	  entry.should respond_to(:memory_box)
  	end
  end
end
