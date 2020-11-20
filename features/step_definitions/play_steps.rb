And /^I draw the following number of cards: (.*?)$/ do |cards|
  cards = cards.to_i - 1
  cards = 0..cards
  cards.each {click_button "draw"}
end


When /^'(.*?)' discards '(.*?)' cards$/ do |username,number_cards|
  id = User.where(username: username).first.id
  hand = Hand.where(user_id: id)

  hand.each_with_index do |card,i|
    if i < (number_cards.to_i)
      check("played_cards_#{card.card_id}")
    end
  end
  click_button "discard"
end

Then /^'(.*?)' should only have '(.*?)' cards$/ do |username, number|
  id = User.where(username: username)
  expect(Hand.where(user_id: id).length()).to be number
end