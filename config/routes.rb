# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get '/twilio-number',         to: 'home#twilio_number'
  get '/spotify-login',         to: 'home#spotify_login'
  get '/auth/spotify/callback', to: 'home#callback'
  get '/check-user',            to: 'home#check_user'
  get '/bot',                   to: 'home#genius_bot'

  namespace :twilio do
    post 'messages', to: 'messages#create'
  end
end
