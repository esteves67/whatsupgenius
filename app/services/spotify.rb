# frozen_string_literal: true

# Spotify service
class Spotify
  def initialize(user)
    @user = RSpotify::User.new(
      'id':          user.spotify_user_id,
      'credentials': {
        'expires':       user.expires,
        'expires_at':    user.expires_at,
        'token':         user.token,
        'refresh_token': user.refresh_token
      }
    )
  end

  def self.track_search(query)
    RSpotify::Track.search(query).first
  end

  def add_to_playlist(playlist_id, track_id)
    playlist = RSpotify::Playlist.find(@user.id, playlist_id)
    playlist.add_tracks!([track_id])
  end
end
