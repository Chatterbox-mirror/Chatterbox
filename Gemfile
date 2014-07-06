
#source 'https://rubygems.org'
source 'http://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'
gem 'devise'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'responders'
gem 'kaminari'
gem 'has_scope'
gem 'carrierwave'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
group :development do
  gem 'byebug'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano3-puma', github: "seuros/capistrano-puma"
end


group :test, :development do
  gem 'spring-commands-rspec'
  gem "rspec-rails"
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec', require: false
  gem 'rack-livereload'
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
  gem 'guard-cucumber'
  gem 'guard-bundler'
  gem 'guard-jruby-rspec', platforms: :jruby
end

group :test do
  gem "factory_girl_rails"
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'ruby_gntp'
  gem 'quiet_assets'
  gem 'forgery'
  gem 'cucumber-rails', require: false
end

gem 'puma', :platforms => [:jruby, :ruby]

# Use debugger
# gem 'debugger', group: [:development, :test]
