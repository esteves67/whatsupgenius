# frozen_string_literal: true

class MessageManager
  # If you want to add some responses that will be interpreted,
  # just put them within these constants!
  POSITIVE_RESPONSES = %w[yes oui yeah ouais yep yup 👍].freeze
  NEGATIVE_RESPONSES = %w[no non nah nan nope 👎].freeze

  # This method is used to manage user's message if the first word
  # of the message is 'wug'
  def self.message(session_track, query)
    track = Spotify.track_search(query)

    if track
      session_track = track.uri
      message = I18n.t('.messages.want_to_add_html', track_name: track.name, track_artist: track.artists.map(&:name).to_sentence)
    else
      message = I18n.t('.messages.no_result_html', query: query)
    end

    [session_track, message]
  end

  # Here, we handling the user's response after being sent a result
  def self.track(session_track, query, spotify, user)
    answer = query.split
    if answer_checker(answer)
      message = I18n.t('.messages.positive_response')
      spotify.add_to_playlist(user.playlist_id, session_track)
      session_track = nil
    elsif answer_checker(answer, false)
      session_track = nil
      message = I18n.t('.messages.negative_response')
    end

    [session_track, message]
  end

  class << self
    private

    def answer_checker(answer, positive = true)
      if positive
        answer.any? { |word| POSITIVE_RESPONSES.include?(word.strip) }
      else
        answer.any? { |word| NEGATIVE_RESPONSES.include?(word.strip) }
      end
    end
  end
end
