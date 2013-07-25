Given(/^"(.*?)" posts a request to invite users to the memory box "(.*?)" with the JSON$/) do |user_email, memory_box_name, json|
  @user = User.find_by_email(user_email)
  @memory_box = @user.memory_boxes.find_by_title(memory_box_name)
	post("/api/user/memory_boxes/#{@memory_box.id}/invitations.json?auth_token=#{@user.authentication_token}", JSON.parse(json))
end

Then(/^"(.*?)" should have a pending invitation$/) do |email|
  @user = User.find_by_email(email)
  @user.invitations.should_not be_empty
end

Then(/^"(.*?)" should have (\d+) sent invitations$/) do |email, count|
  @user = User.find_by_email(email)
  @user.sent_invitations.count.should eq count.to_i
end

Then(/^"(.*?)" should have recieved (\d+) invitation$/) do |email, count|
  @user = User.find_by_email(email)
  @user.received_invitations.count.should eq count.to_i
end