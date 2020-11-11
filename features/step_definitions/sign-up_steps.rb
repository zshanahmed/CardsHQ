

Given /^the following users exist:$/ do |user_table|
  user_table.hashes.each {|usr| User.create!(usr)}

end


Given /^I'm on the sign-up page$/ do
  visit new_user_path
end

When /^I try to create new account with username: "(.*?)"$/ do |arg1|

  fill_in "username", with: arg1
end
And  /^With email: "(.*?)"$/ do |arg1|
  fill_in "email", with: arg1

end

And /^With password: "(.*?)"$/ do |arg1|
  fill_in "password", with: arg1

end

And /^I press Create my account$/ do
  click_button "Create my account"
end

Then /^I should see: "(.*?)"$/ do |arg1|
  page.should have_selector ".alert", text: arg1
end