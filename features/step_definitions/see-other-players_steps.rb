
Given /^Given I'm logged in with GrumpyBunny$/ do
  visit login_path
  fill_in 'loginUser', with: "GrumpyBunny"
  fill_in 'loginEmail', with: "123"
end

And /^I'm on the show page$/ do
  visit rooms_path
end

When /^"(.*?)" draws "(.*?)" cards $/ do |user_name, num_cards|

end

Then /^I should see "(.*?)" with "(.*?)" cards $/ do |user_name, num_cards|
  page.has_content?(user_name)
  page.has_content?(num_cards)
end