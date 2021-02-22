# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 6.0'

# DSLs
gem 'sassc-rails', '~> 2.1'
gem 'slim-rails', '~> 3.2'

# Helpers
gem 'jbuilder', '~> 2.9', '>= 2.9.1'

# Assets
gem 'bootstrap', '~> 4.3', '>= 4.3.1'
gem 'jquery-rails', '~> 4.3', '>= 4.3.5'
gem 'webpacker', '~> 4.0', '>= 4.0.7'

# Javascript tools
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
gem 'uglifier', '~> 4.2'

# APIs
gem 'genius', '~> 0.1.1'
gem 'rspotify', '~> 2.6'
gem 'twilio-ruby', '~> 5.29'

# I'm using a fork of omniauth-oauth2 to fix the redirection
# problem with RSpotify.
gem 'omniauth-oauth2', git: 'https://github.com/escanxr/omniauth-oauth2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'capistrano-rails', '~> 1.4'
  gem 'foreman', '~> 0.86.0'
  gem 'listen', '~> 3.2'
  gem 'puma', '~> 4.2', '>= 4.2.1'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1'
  gem 'web-console', '~> 4.0', '>= 4.0.1'
end
