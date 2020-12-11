require 'pry'
include Warden::Test::Helpers
Warden.test_mode!

def login_help (email, password)
  @user = User.create!(:email=>email, :password=>password, confirmed_at: Time.now)
  @room = Room.create(name: 'testroom')
end

Given(/^I have logged in with email and password: (.*?)$/) do |args1|
  args = args1.split(',')
  visit new_user_session_path
  login_help(args[0], args[1])

  # @user.confirm!
  login_as(@user, :scope => :user)
  visit rooms_path

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
  @testroom = Room.create!(name: room_name)
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
  click_button 'Join Room'
  fill_in 'RoomID', with: @testroom.invitation_token
  click_button 'Join Room'
end

When /^I fill in the score with: '(.*?)' and submit$/ do |score|
  fill_in 'score', with: score
  click_button 'updateScore'
end

#
# Reset steps
And /^I press reset$/ do
  click_button 'reset'
end

And /^'(.*?)' cards should be in deck$/ do |cards|
  expect(Card.where(room_id: 1, status: 0).length).to eq(cards.to_i)
end


When(/^(.*?) trades (.*?) cards with (.*?)$/) do |user_trade, num_trade, trade_card|
  click_link "trade"
  user = User.where(username: user_trade).first
  id = user.id
  user_trade = User.where(username: trade_card).first
  user_trade.update!(room_id: user.room_id)
  hand = Hand.where(user_id: id)
  hand.each_with_index do |card,i|
    if i < (num_trade.to_i)
      check("traded_#{card.card_id}")
    end
  end
  fill_in 'tradeuser', with: trade_card
  click_on 'tradebutton'
end

Then /^fails to login$"/ do
  expect()
end


Then(/^I should see the message: "(.*?)"$/) do |arg|
  byebug
  login_as(@user, :scope => :user, :run_callbacks => false)
  # @current_user = controller.current_user
  click_on 'btn-room'
  fill_in 'RoomID', :with => @room.invitation_token
  click_button 'btn-join'
  page.should have_selector ".alert", text: arg
end