


Given /^I'm on the other-players page$/ do
  visit rooms_path
end

Then /^I should see "(.*?)" with "(.*?)" cards $/ do |user_name, num_cards|
  page.has_content?(user_name)
  page.has_content?(num_cards)
end