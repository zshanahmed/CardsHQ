And /^I draw the following number of cards: (.*?)$/ do |cards|
  cards = cards.to_i - 1
  0..cards.each {click_button "DRAW"}
end


When /^'(.*?)' discards '(.*?)' cards$/ do |username,number_cards|
  id = User.where(username: username).first.id
  hand = Hand.where(user_id: id)
  x = 0..number_cards-1
  x.each do |num|
    check("card_#{hand[num].id}")
  end
  click_button "discard"
end

Then /^'(.*?)' should only have '(.*?)' cards$/ do |username, number|
  id = User.where(username: username)
  expect(Hand.where(user_id: id).length()).to be number
end