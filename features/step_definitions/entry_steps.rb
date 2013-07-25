Given(/^a memory box with the following entries:$/) do |table|
  table.hashes.each do |entries|
    @entry = FactoryGirl.create(:entry, description: entries["description"])
    @entry.memory_box_id = @memory_box.id
    @memory_box.entries << @entry
  end
end

Given(/^I request all of the entries$/) do
  visit "/api/user/memory_boxes/#{@memory_box.id}/entries.json?auth_token=#{@user.authentication_token}"
end

Given(/^I request a entry$/) do
  visit "/api/user/memory_boxes/#{@memory_box.id}/entries/#{@entry.id}.json?auth_token=#{@user.authentication_token}"
end

Given(/^I send a delete request for the entry$/) do
  delete "/api/user/memory_boxes/#{@memory_box.id}/entries/#{@entry.id}.json?auth_token=#{@user.authentication_token}"
end

Then(/^the memory box should have (\d+) entries$/) do |count|
  @memory_box.entries.count.should eq count.to_i
end

Then(/^the entries description should be "(.*?)"$/) do |description|
  @entry.reload.description.should eq description
end

Given(/^I create an entry with the following fields:$/) do |table|
  post("/api/user/memory_boxes/#{@memory_box.id}/entries.json?auth_token=#{@user.authentication_token}", entry: table.hashes.first)
end

Given(/^I update the entry with the following attributes:$/) do |table|
  put("/api/user/memory_boxes/#{@memory_box.id}/entries/#{@entry.id}.json?auth_token=#{@user.authentication_token}", entry: table.hashes.first)
end