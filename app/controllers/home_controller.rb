# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action(:verify_authenticity_token, only: :callback)

  def index
  end

  def spotify_login
    token = params[:user_token]
    uri = URI('https://accounts.spotify.com/authorize')
    params = {
      response_type: 'code',
      client_id:     ENV['SPOTIFY_CLIENT_ID'],
      scope:         'playlist-modify-public user-read-email',
      redirect_uri:  auth_spotify_callback_url,
      state:         token
    }

    uri.query = URI.encode_www_form(params)
    render json: { uri: uri.to_s }
  end

  def callback
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user_token = params[:state]
    phone_number = cookies[:phoneNumber]

    @user = User.perform(spotify_user, user_token, phone_number)

    if @user.valid?
      playlist_name = cookies[:playlistName]
      new_playlist = spotify_user.create_playlist!(playlist_name)
      @user.update(playlist_id: new_playlist.id)
      render 'close_tab'
    else
      render json: { status: 'error' }
    end
  end

  def check_user
    token = params[:user_token]
    user  = User.find_by(user_token: token)

    if user
      render json: { status: 'matched' }
    else
      render json: { status: 'unmatched' }
    end
  end

  def genius_bot
    head 200, content_type: 'json'
  end
end
