source 'https://rubygems.org'

ruby '2.7.7'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11.3'

gem 'devise'

gem 'rack-cors'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'factory_bot_rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass'

gem 'omniauth-twitter'
gem 'omniauth-facebook'
#sendgrid for email
gem 'sendgrid-ruby'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'activerecord-session_store', '~> 1.0'
# Use Unicorn as the app server
# gem 'unicorn'
gem 'bigdecimal', '1.3.5'

# for real time updates
gem 'pusher'
gem 'figaro'

# passes rails data to js
gem 'gon'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'simplecov', require: false, group: :test
group :development, :test do
  gem 'byebug'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'rspec', '~>3.5'
  gem 'rspec-rails'

  gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'

  gem 'jasmine-rails'
  gem 'jasmine-jquery-rails'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.3.6'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'dotenv', '~> 2.2.1'

end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 3.2.0'
  gem 'rspec-expectations'
end

group :production do
  gem 'pg' ,'~> 0.21'# for Heroku deployment
  gem 'rails_12factor'
end

