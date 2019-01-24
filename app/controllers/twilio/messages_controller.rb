# frozen_string_literal: true

module Twilio
  # Manage the user reponses
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      query = params['Body']
      spotify = Spotify.new(User.last)

      if session[:track]
        answer = query.split(' ').first.downcase.strip
        if ['yes', 'yeah', 'yep', 'yup', '👍'].include? answer
          message = 'OK, adding that track now.'
          spotify.add_to_playlist(User.last.playlist_id, session[:track])
          session[:track] = nil
        elsif ['no', 'nah', 'nope', '👎'].include? answer
          session[:track] = nil
          message = 'What do you want to add?'
        end
      end

      unless message
        track = Spotify.track_search(query)
        if track
          session[:track] = track.uri
          message = "Did you want to add _#{track.name}_ by _#{track.artists.map(&:name).to_sentence}_?"
        else
          message = "I couldn't find any songs by searching for '#{body}'. Try something else."
        end
      end

      response = Twilio::TwiML::MessagingResponse.new
      response.message(body: message)
      render xml: response.to_xml
    end
  end
end
