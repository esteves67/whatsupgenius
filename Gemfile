# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'capistrano-rails', group: :development
gem 'bootsnap', '>= 1.1.0', require: false
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.2'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails', '~> 3.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

gem 'rspotify', '~> 2.4', '>= 2.4.1'
gem 'twilio-ruby', '~> 5.19'
# I have to use this OAuth2 version to prevent an issue caused by
# the redefinition of callback_url in the 1.4.0 version.
# Restoring the callback_url method with a OAuth2 subclass
# should be a solution.
# See https://github.com/omniauth/omniauth-oauth2/issues/81 for more details.
gem 'omniauth-oauth2', '~> 1.3', '>= 1.3.1'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
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
