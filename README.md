# CardsHQ

To use this product clone the main branch using

```
git clone https://github.com/zshanahmed/CardsHQ.git

```

After cloning this project make sure you have the following installed.

```
ruby: 2.6.6
rails: 4.2.11.3
RubyMine from IntelliJ

```
Once all the required software is installed. Open the project in ruby mine and follow the following procedure.

1. gem install bundler ( if bundler is not installed)
2. bundle install ( to install all the gems listed in the .gemfile)
3. bundle exec rake db:migrate ( to migrate the database )
4. bundle exec rake db:schema:load
5. bundle exec rake db:seed ( to seed the database with dummy values in development)
6. bundle exec rake routes 
7. bundle exec rails server ( to start and run the server)

CardsHQ can be accessed at: https://cardshq.onrender.com/
