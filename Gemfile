# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'image_processing', '~> 1.2'
gem 'rails', '~> 5.2.6'
gem 'shrine', '~> 3.3'
gem 'shrine-cloudinary', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg'
gem 'pundit'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'dotenv-rails'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rack-cors'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false, group: :test
end

# gem 'activestorage-cloudinary-service'
gem 'bootstrap', '~> 4.1.1'
gem 'bootstrap_form', '~> 4.0'
gem 'carrierwave'
gem 'cloudinary'
gem 'devise'
gem 'figaro'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'kaminari'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
end
