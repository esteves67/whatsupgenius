# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def callback
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    @user = User.perform(spotify_user)

    if @user.valid?
      playlist_name     = cookies[:playlist_name]
      new_playlist      = spotify_user.create_playlist!(playlist_name)
      @user.update(playlist_id: new_playlist.id)

      render :success
    else
      render :index
    end
  end
end
