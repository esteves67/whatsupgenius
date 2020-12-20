# frozen_string_literal: true

class GeniusLyrics
  Genius.access_token = Rails.application.credentials.genius[:access_token]

  def self.get_lyrics(query, user_language)
    song = Genius::Song.search(query).first
    return song.url if song

    I18n.t('.messages.no_lyrics_sentences', locale: user_language).sample
  end
end
