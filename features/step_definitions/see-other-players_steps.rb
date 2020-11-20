

Given /^I'm logged in with "(.*?)" with password "(.*?)" and in room "(.*?)"$/ do |username, roomname|
  visit login_path
  fill_in 'loginUser', with: username
  fill_in 'loginEmail', with: "123"
  click_button 'Create My Room'
  fill_in 'RoomName', with: roomname
  click_button 'Create My Room'
end


Then /^I should see "(.*?)" with "(.*?)" cards $/ do |username, numcards|
  page.should have_xpath('//table#users/thead/tr/td#username', :text)
  page.has_xpath?('//table#users/thead/tr/td#username', text: username)
  page.has_xpath?('//table#users/thead/tr/td#username', text: numcards)
end