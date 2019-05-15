# frozen_string_literal: true

class User < ApplicationRecord
  validates(:spotify_user_id,
    :email,
    :expires,
    :expires_at,
    :token,
    :refresh_token,
    :user_token,
    :phone_number,
    presence: true)

  def self.perform(spotify_user, user_token, phone_number)
    User.new(
      spotify_user_id: spotify_user.id,
      email:           spotify_user.email,
      expires:         spotify_user.credentials['expires'],
      expires_at:      spotify_user.credentials['expires_at'],
      token:           spotify_user.credentials['token'],
      refresh_token:   spotify_user.credentials['refresh_token'],
      user_token:      user_token,
      phone_number:    phone_number
    )
  end
end
