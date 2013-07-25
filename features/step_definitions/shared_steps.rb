Given(/^I post to "(.*?)" with:$/) do |url, json|
  post(url, JSON.parse(json))
end

Given(/^I post to "(.*?)" with the JSON:$/) do |url, json|
  post "#{url}.json?auth_token=#{@user.authentication_token}", JSON.parse(json)
end

Given(/^a user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  @user = FactoryGirl.create(:user, email: email, password: password, password_confirmation: password)
end

Then(/^there should be a user with the email "(.*?)"$/) do |email|
	User.find_by_email(email).should_not be_nil
end

def last_json
  page.source
end