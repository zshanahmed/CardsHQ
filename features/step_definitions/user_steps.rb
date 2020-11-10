
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

Then /^I should see: "(.*?)"$/ do |arg1|
  page.should have_selector ".alert", text: arg1
end
