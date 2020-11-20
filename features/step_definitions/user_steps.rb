
Given /^the following users exist:$/ do |user_table|
  user_table.hashes.each {|usr| User.create_user!(usr)}
end

###LOGIN
Given /^I'm on the login page$/ do
  visit login_path
end

Then /^I should see a username field and password field$/ do
  expect(page).to have_field('loginUser')
  expect(page).to have_field('loginEmail')

end

When /^I enter username as "(.*?)"$/ do |username|

  fill_in 'loginUser', with: username

end

And /^password as "(.*?)"$/ do |password|

  fill_in 'loginEmail', with: password

end

And /^I press submit$/ do
  click_button 'login_submit'
end


###Signup

Given /^I'm on the sign-up page$/ do
  visit new_user_path
end

When /^I enter username,email,password and press submit: "(.*?)"$/ do |arg1|
  args = arg1.split(',')
  fill_in "username", :with => "user=>#{args[0]}"
  fill_in "email", :with => "user=>#{args[1]}"
  fill_in "password", :with => "user=>#{args[2]}"
  click_button("UserCreate")
end

Then /^I should see: "(.*?)"$/ do |arg1|
  page.should have_selector ".alert", text: arg1
end

##### Logout steps


When /^I login to the account with info: "(.*?)"$/ do |account_info|
  info = account_info.split(",")
  fill_in 'loginUser', with: info[0]
  fill_in 'loginEmail', with: info[1]
  click_button 'login_submit'
end

And /^press logout button$/ do
  click_button 'logout'
end

And /^Im taken to the login page$/ do
  expect(page).to have_field('loginUser')
  expect(page).to have_field('loginEmail')
end

Then /^I shouldn't see a logout button$/ do
  expect {page.find_by_id('logout')}.to raise_error
end