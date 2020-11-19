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
  User.create_user!(users)
end

