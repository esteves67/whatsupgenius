# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get '/check-user',            to: 'home#check_user'
  get '/auth/spotify/callback', to: 'api/spotify#callback'

  namespace :api do
    post 'twilio/messages', to: 'twilio#create'
    get  'twilio/data',     to: 'twilio#data'
    get  'spotify/login',   to: 'spotify#login'
  end
end
