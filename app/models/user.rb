# frozen_string_literal: true

class User < ApplicationRecord
  def self.perform(spotify_user)
    User.new(
      spotify_user_id: spotify_user.id,
      email:           spotify_user.email,
      expires:         spotify_user.credentials['expires'],
      expires_at:      spotify_user.credentials['expires_at'],
      token:           spotify_user.credentials['token'],
      refresh_token:   spotify_user.credentials['refresh_token']
    )
  end
end
