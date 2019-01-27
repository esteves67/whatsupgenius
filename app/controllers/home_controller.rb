# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @playlist_id = ENV.fetch('SPOTIFY_PLAYLIST_ID', nil)
    @user_id = ENV.fetch('SPOTIFY_USER_ID', nil)
  end

  def callback
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    @user = User.new(spotify_user_id: spotify_user.id,
                     email: spotify_user.email,
                     expires: spotify_user.credentials['expires'],
                     expires_at: spotify_user.credentials['expires_at'],
                     token: spotify_user.credentials['token'],
                     refresh_token: spotify_user.credentials['refresh_token'])

    if @user.valid?
      new_playlist = spotify_user.create_playlist!("What's up Genius?")
      @user.playlist_id = new_playlist.id
      @user.save!
      render :callback
    else
      render :index
    end
  end
end
