
And /^"(.*?)" and "(.*?)" both have "(.*?)" cards$/ do | user1, user2, num_cards|
  user_id1 = User.where(username: user1)
  user_id2 = User.where(username: user2)

  user_id1
end