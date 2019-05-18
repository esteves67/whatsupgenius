# frozen_string_literal: true

class MessageManager
  POSITIVE_RESPONSES = %w[yes oui yeah ouais yep yup 👍].freeze
  NEGATIVE_RESPONSES = %w[no non nah nan nope 👎].freeze

  def self.track(session_track, query, spotify, user)
    answer = query.split(' ').first.downcase.strip

    if POSITIVE_RESPONSES.include?(answer)
      message = I18n.t('.messages.positive_response')
      spotify.add_to_playlist(user.playlist_id, session_track)
      session_track = nil
    elsif NEGATIVE_RESPONSES.include?(answer)
      session_track = nil
      message = I18n.t('.messages.negative_response')
    end

    [session_track, message]
  end

  def self.message(session_track, query)
    track = Spotify.track_search(query)

    if track
      session_track = track.uri
      message = I18n.t('.messages.want_to_add', track_name: track.name, track_artist: track.artists.map(&:name).to_sentence)
    else
      message = I18n.t('.messages.no_result', query: query)
    end

    [session_track, message]
  end
end
