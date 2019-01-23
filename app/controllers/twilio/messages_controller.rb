# frozen_string_literal: true

module Twilio
  # Manage the user reponses
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      body = params['Body']
      spotify = Spotify.new(ENV['SPOTIFY_USER_ID'],
                            ENV['SPOTIFY_TOKEN'],
                            ENV['SPOTIFY_REFRESH_TOKEN'])

      if session[:track]
        answer = body.split(' ').first.downcase.strip
        if ['yes', 'yeah', 'yep', 'yup', '👍'].include? answer
          message = 'OK, adding that track now.'
          spotify.add_to_playlist(ENV['SPOTIFY_PLAYLIST_ID'], session[:track])
          session[:track] = nil
        elsif ['no', 'nah', 'nope', '👎'].include? answer
          session[:track] = nil
          message = 'What do you want to add?'
        end
      end

      return unless message

      track = spotify.track_search(body)
      if track
        session[:track] = track.uri
        message = "Did you want to add '#{track.name}' by
                  '#{track.artists.map(&:name).to_sentence}' ?"
      else
        message = "I couldn't find any songs by searching for '#{body}'.
                    Try something else."
      end

      response = Twilio::TwiML::MessagingResponse.new
      response.message(body: message)
      render xml: response.to_xml
    end
  end
end
