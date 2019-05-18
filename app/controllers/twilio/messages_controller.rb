# frozen_string_literal: true

module Twilio
  # Manage the user reponses
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      query = params[:Body]
      user = User.sender(params[:From])
      spotify = Spotify.new(user)

      if session[:track]
        service_responses = MessageManager.track(session[:track], query, spotify, user)

        session[:track] = service_responses[0]
        message = service_responses[1]
      end

      unless message
        service_responses = MessageManager.message(session[:track], query)

        session[:track] = service_responses[0]
        message = service_responses[1]
      end

      response = Twilio::TwiML::MessagingResponse.new
      response.message(body: message)
      render(xml: response.to_xml)
    end
  end
end
