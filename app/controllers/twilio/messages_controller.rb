# frozen_string_literal: true

module Twilio
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      query = sanitarized_query
      user = User.sender(params[:From])
      spotify = Spotify.new(user)

      if session[:track]
        service_responses = MessageManager.track(session[:track], query, spotify, user)

        session[:track] = nil
        message = service_responses[1]
      end

      message ||= request_management(query, user)

      if message
        response = Twilio::TwiML::MessagingResponse.new
        response.message(body: message)
        render(xml: response.to_xml)
      else
        head 200, content_type: 'text/xml'
      end
    end

  private

    def sanitarized_query
      params[:Body].downcase.split.map { |word| word.gsub(/[[:punct:]]/, '') }.join(' ')
    end

    def request_management(query, user)
      if query.split.first.casecmp('wug').zero?
        query = query.remove('wug ')
        user.update(last_request: query)
        service_responses = MessageManager.message(session[:track], query)

        session[:track] = service_responses[0]
        service_responses[1]
      elsif query.split.first.casecmp('lyrics').zero?
        query = query.remove('lyrics ')
        # If a user sends only "lyrics", the bot returns the lyrics of the last searched song with the 'wug' keyword
        if query == 'lyrics'
          query = user.last_request || I18n.t('.messages.no_last_request')
        end

        session[:track] = nil
        GeniusLyrics.get_lyrics(query)
      end
    end
  end
end
