# frozen_string_literal: true

require 'rspotify/oauth'

RSpotify.authenticate(
  Rails.application.credentials.spotify[:client_id],
  Rails.application.credentials.spotify[:client_secret]
)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:spotify,
           Rails.application.credentials.spotify[:client_id],
           Rails.application.credentials.spotify[:client_secret],
           scope:                  'playlist-modify-public user-read-email',
           provider_ignores_state: true)
end
