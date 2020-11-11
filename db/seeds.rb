# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
    {:username => "GrumpyBunny", :email => "botiqueBooth@gmail.com", :password => '123'},
    {:username => "bablingCreek", :email => "creepyLawyer@creepyLawyer.gov", :password => "1234"},
    {:username => "WarmBlanket", :email => "Beethoven@vienna.edu", :password => "goodpassword"},
    {:username => "softPillow", :email => "saltedButterWasAMistake@walmart.com", :password => "glorrrious"},
    {:username => "rollingHills", :email => "300@thisIsSparta.com", :password => "PersiansSuck"}
]

users.each do |users|
  User.create!(users)
end

cards = [
    {:suit => "Hearts" , :rank => "2"},
    {:suit => "Hearts" , :rank => "3"},
    {:suit => "Hearts" , :rank => "4"},
    {:suit => "Hearts" , :rank => "5"},
    {:suit => "Hearts" , :rank => "6"},
    {:suit => "Hearts" , :rank => "7"},
    {:suit => "Hearts" , :rank => "8"},
    {:suit => "Hearts" , :rank => "9"},
    {:suit => "Hearts" , :rank => "10"},
    {:suit => "Hearts" , :rank => "Jack"},
    {:suit => "Hearts" , :rank => "Queen"},
    {:suit => "Hearts" , :rank => "King"},
    {:suit => "Hearts" , :rank => "Ace"},
    {:suit => "Spades" , :rank => "2"},
    {:suit => "Spades" , :rank => "3"},
    {:suit => "Spades" , :rank => "4"},
    {:suit => "Spades" , :rank => "5"},
    {:suit => "Spades" , :rank => "6"},
    {:suit => "Spades" , :rank => "7"},
    {:suit => "Spades" , :rank => "8"},
    {:suit => "Spades" , :rank => "9"},
    {:suit => "Spades" , :rank => "10"},
    {:suit => "Spades" , :rank => "Jack"},
    {:suit => "Spades" , :rank => "Queen"},
    {:suit => "Spades" , :rank => "King"},
    {:suit => "Spades" , :rank => "Ace"},
    {:suit => "Clubs" , :rank => "2"},
    {:suit => "Clubs" , :rank => "3"},
    {:suit => "Clubs" , :rank => "4"},
    {:suit => "Clubs" , :rank => "5"},
    {:suit => "Clubs" , :rank => "6"},
    {:suit => "Clubs" , :rank => "7"},
    {:suit => "Clubs" , :rank => "8"},
    {:suit => "Clubs" , :rank => "9"},
    {:suit => "Clubs" , :rank => "10"},
    {:suit => "Clubs" , :rank => "Jack"},
    {:suit => "Clubs" , :rank => "Queen"},
    {:suit => "Clubs" , :rank => "King"},
    {:suit => "Clubs" , :rank => "Ace"},
    {:suit => "Diamonds" , :rank => "2"},
    {:suit => "Diamonds" , :rank => "3"},
    {:suit => "Diamonds" , :rank => "4"},
    {:suit => "Diamonds" , :rank => "5"},
    {:suit => "Diamonds" , :rank => "6"},
    {:suit => "Diamonds" , :rank => "7"},
    {:suit => "Diamonds" , :rank => "8"},
    {:suit => "Diamonds" , :rank => "9"},
    {:suit => "Diamonds" , :rank => "10"},
    {:suit => "Diamonds" , :rank => "Jack"},
    {:suit => "Diamonds" , :rank => "Queen"},
    {:suit => "Diamonds" , :rank => "King"},
    {:suit => "Diamonds" , :rank => "Ace"}
]

cards.each do |card|
  Deck.create!(card)
end