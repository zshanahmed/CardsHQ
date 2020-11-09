Given /^I'm on the login page$/ do
  visit login_path
end

Then /^I should see a username field and password field$/ do
  expect(page).to have_content('username')
  expect(page).to have_content('password')
end

When /^I enter username as "(.*?)"$/ do |username|
  fill_in('Username', with: username)
end

And /^password as "(.*?)"$/ do |password|
  fill_in('Password', with: password)
end



