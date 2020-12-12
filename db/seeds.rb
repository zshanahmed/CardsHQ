# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
    {:username => "GrumpyBunny", :email => "botiqueBooth@gmail.com", :password => '123123123', :confirmed_at=>"2020-12-09 01:31:06.594"},
    {:username => "bablingCreek", :email => "creepyLawyer@creepyLawyer.gov", :password=>'123123123', :confirmed_at=>Date.today},
    {:username => "WarmBlanket", :email => "Beethoven@vienna.edu", :password => '123123123', :confirmed_at=>Date.today},
    {:username => "softPillow", :email => "saltedButterWasAMistake@walmart.com", :password => "123123123", :confirmed_at=>Date.today},
    {:username => "rollingHills", :email => "300@thisIsSparta.com", :password => "123123123", :confirmed_at=>Date.today}
]





users.each do |users|
  User.create!(users)
end
