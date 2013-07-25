Given(/^the following memory boxes:$/) do |table|
	table.hashes.each do |memory_box|
		@memory_box = @user.create_memory_box!(title: memory_box["title"])
	end
end

Given(/^I post a request to create a memory box$/) do |json|
  post("/api/user/memory_boxes.json?auth_token=#{@user.authentication_token}", JSON.parse(json))
end

Then(/^the user should have (\d+) memory boxe?s?$/)  do |count|
  @user.memory_boxes.count.should eq count.to_i
end

Given(/^I request all of the user's memory boxes$/) do
	visit("/api/user/memory_boxes.json?auth_token=#{@user.authentication_token}")
end

Given(/^I request a memory box$/) do
	visit("/api/user/memory_boxes/#{@memory_box.id}.json?auth_token=#{@user.authentication_token}")
end

Given(/^I send a delete request for the memory box$/) do
  delete "/api/user/memory_boxes/#{@memory_box.id}.json?auth_token=#{@user.authentication_token}"
end

Given(/^I send a put request for the memory box with the JSON:$/) do |json|
  put "/api/user/memory_boxes/#{@memory_box.id}.json?auth_token=#{@user.authentication_token}", JSON.parse(json)
end

Then(/^the memory boxes title should be "(.*?)"$/) do |title|
  @memory_box.reload.title.should eq title
end