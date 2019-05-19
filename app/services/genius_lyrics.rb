# frozen_string_literal: true

class GeniusLyrics
  Genius.access_token = ENV['GENIUS_ACCESS_TOKEN']

  def self.get_lyrics(query)
    song = Genius::Song.search(query).first
    if song
      song.url
    else
      I18n.t('.messages.no_lyrics_sentences').sample
    end
  end
end
