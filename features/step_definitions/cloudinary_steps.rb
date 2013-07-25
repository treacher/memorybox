Given(/^I post a request to create a signature for the params "(.*?)"$/) do |arg1|
  post("/api/cloudinary.json?auth_token=#{@user.authentication_token}")
end

Then(/^there response should contain the signature "(.*?)"$/) do |signature|
  response.body.should eq signature
end