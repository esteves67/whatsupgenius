# frozen_string_literal: true

begin
  require 'rspotify/oauth'

  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :spotify, ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'], scope: 'playlist-modify-public user-read-email'
  end
end
