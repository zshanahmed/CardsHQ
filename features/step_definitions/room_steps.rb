Given(/^I have logged in with username and password: (.*?)$/) do |args1|
  args = args1.split(',')
  visit login_path
  fill_in 'loginUser', with: args[0]
  fill_in 'loginEmail', with: args[1]
  click_on 'Log in'
end

Given /^following (.*?) exist:$/ do |room_table|
  room_table.hashes.each { |room| Room.create(room) }
end

And(/^I am on the dashboard page$/) do
  visit rooms_path
end

When(/^I click the button: '(.*?)'$/) do |text|
  click_on text
end

And(/^the room with room name as '(.*?)' already exists$/) do |room_name|
  @testroom = Room.create(name: room_name)
end

And(/^I submit room name as: '(.*?)'$/) do |room_name|
  fill_in 'RoomName', with: room_name
  click_button 'Create My Room'
end

Then(/^I should go to the room page with text: '(.*?)'$/) do |room_title|
  page.should have_selector 'h2', text: room_title
end


And(/^then I submit the correct invitation code$/) do
  fill_in 'RoomID', with: @testroom.invitation_token
  click_on 'Join Room'
end


And(/^then I submit the incorrect invitation code$/) do
  fill_in 'RoomID', with: '0'
  click_on 'Join Room'
end

Given(/^I have joined the room: '(.*?)'$/) do |args|
  click_on 'Join Room'
  fill_in 'RoomID', with: @testroom.invitation_token
  click_on 'Join Room'
end

When /^I fill in the score with: '(.*?)' and submit$/ do |score|
  fill_in 'score', with: score
  click_button 'updateScore'
end