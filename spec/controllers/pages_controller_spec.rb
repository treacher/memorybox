require 'spec_helper'

describe PagesController do

  let(:user) { FactoryGirl.create(:user) }

  describe "GET 'privacy_policy'" do
    it "returns http success" do
      get 'privacy'
      response.should be_success
    end
  end

  describe "GET 'terms_and_conditions'" do
    it "returns http success" do
      get 'terms'
      response.should be_success
    end
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end
end