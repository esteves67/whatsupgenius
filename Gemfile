# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 5.2.2'

# DSLs
gem 'coffee-rails', '~> 4.2'
gem 'sassc-rails', '~> 2.1'
gem 'slim-rails', '~> 3.2'

# Helpers
gem 'bootsnap', '>= 1.1.0', require: false
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'jbuilder', '~> 2.5'

# Assets
gem 'bootstrap', '~> 4.2', '>= 4.2.1'
gem 'font-awesome-sass', '~> 5.6', '>= 5.6.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'webpacker', '~> 3.5', '>= 3.5.5'

# Javascript tools
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# APIs
gem 'genius', '~> 0.1.1'
gem 'rspotify', '~> 2.4', '>= 2.4.1'
gem 'twilio-ruby', '~> 5.19'

# I'm using a fork of omniauth-oauth2 to fix the redirection
# problem with RSpotify.
gem 'omniauth-oauth2', git: 'https://github.com/escanxr/omniauth-oauth2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano-rails', '~> 1.4'
  gem 'foreman', '~> 0.85.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'puma', '~> 3.11'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.1'
  gem 'selenium-webdriver'
end
