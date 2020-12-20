# frozen_string_literal: true

class Api::SpotifyController < ApplicationController
  skip_before_action(:verify_authenticity_token, only: :callback)

  def login
    token = params[:user_token]
    uri = URI('https://accounts.spotify.com/authorize')
    params = {
      response_type: 'code',
      client_id:     Rails.application.credentials.spotify[:client_id],
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
    language = request.env['HTTP_ACCEPT_LANGUAGE'].split('-').first

    @user = User.perform(spotify_user, user_token, phone_number, language)

    if @user.valid?
      playlist_name = cookies[:playlistName]
      new_playlist = spotify_user.create_playlist!(playlist_name)
      @user.update(playlist_id: new_playlist.id)
      render 'home/close_tab'
    else
      render json: { status: 'error' }
    end
  end
end
