# frozen_string_literal: true

module Twilio
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      query = params[:Body].downcase
      user = User.sender(params[:From])
      spotify = Spotify.new(user)

      if session[:track]
        service_responses = MessageManager.track(session[:track], query, spotify, user)

        session[:track] = service_responses[0]
        message = service_responses[1]
      end

      unless message
        if query.split.first.casecmp('wug').zero?
          query = query.remove('wug ')
          service_responses = MessageManager.message(session[:track], query)

          session[:track] = service_responses[0]
          message = service_responses[1]
        end
      end

      if message
        response = Twilio::TwiML::MessagingResponse.new
        response.message(body: message)
        render(xml: response.to_xml)
      else
        head 200, content_type: 'text/xml'
      end
    end
  end
end
