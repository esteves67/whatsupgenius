# frozen_string_literal: true

class MessageManager
  # If you want to add some responses that will be interpreted, just put them within these constants.
  POSITIVE_KEYWORDS = I18n.t('.messages.positive_keywords').freeze
  NEGATIVE_KEYWORDS = I18n.t('.messages.negative_keywords').freeze

  # This method is used to manage user's message if the first word of the message is 'wug'
  def self.message(session_track, query, user_language)
    track = Spotify.track_search(query)

    if track
      session_track = track.uri
      message = I18n.t('.messages.result_sentences',
                       track_name:   track.name,
                       track_artist: track.artists.map(&:name).to_sentence(locale: user_language),
                       locale:       user_language).sample
    else
      message = I18n.t('.messages.no_result_sentences', query: query, locale: user_language).sample
    end

    [session_track, message]
  end

  # Here, we're handling the user's response after being sent a result
  def self.track(session_track, query, spotify, user)
    answer = query.split
    if answer_checker(answer, 'positive')
      message = I18n.t('.messages.positive_responses', locale: user.language).sample
      spotify.add_to_playlist(user.playlist_id, session_track)
    elsif answer_checker(answer, 'negative')
      message = I18n.t('.messages.negative_responses', locale: user.language).sample
    elsif answer_checker(answer, 'lyrics')
      message = GeniusLyrics.get_lyrics(user.last_request, user.language)
    end

    [session_track, message]
  end

  class << self
  private

    def answer_checker(answer, type)
      case type
      when 'positive'
        answer.any? { |word| POSITIVE_KEYWORDS.include?(word.strip) }
      when 'negative'
        answer.any? { |word| NEGATIVE_KEYWORDS.include?(word.strip) }
      when 'lyrics'
        answer.include?('lyrics')
      end
    end
  end
end
