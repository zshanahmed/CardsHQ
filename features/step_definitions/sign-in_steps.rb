Given /the following users exist:/ do |user_table|
  user_table.each {|usr| User.create!(usr)}
end
Given /I'm on the signup page/ do
  visit sign-up_path
end
When /^I try to create a new account with username, email, password: "(.*?)"$/ do |arg1|
  arg1 = arg1.split(",").map {|a| a.gsub(" ", "")}
end