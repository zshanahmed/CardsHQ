

Given /^I'm logged in with "(.*?)" with password "(.*?)" and in room "(.*?)"$/ do |username, password,roomname|
  visit login_path
  fill_in 'loginUser', with: username
  fill_in 'loginEmail', with: password
  click_button 'login_submit'
  click_on 'Create New Room'
  fill_in 'RoomName', with: roomname
  click_button 'Create My Room'
end


Then /^I should see "(.*?)" with "(.*?)" cards$/ do |username, numcards|
  page.should have_content(username)
  page.should have_content(numcards)
end