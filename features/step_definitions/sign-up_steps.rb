

Given /the following users exist:/ do |user_table|
  user_table.hashes.each {|usr| User.create!(usr)}
end


Given /I'm on the sign-up page/ do
  visit users_path
end

When /^I try to create a new account with username "(.*?)" email "(.*?)" password "(.*?)"$/ do |username,email,password|
  arg1 = arg1.split(",").map {|a| a.gsub(" ", "")}

end

Then /^I should see: "(.*?)"$/ do |arg1|

end