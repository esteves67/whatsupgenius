# frozen_string_literal: true

class Api::TwilioController < ApplicationController
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

  def data
    render json: {
      twilioNumber:   Rails.application.credentials.twilio[:phone_number],
      twilioListCode: Rails.application.credentials.twilio[:list_code]
    }
  end

private

  def sanitarized_query
    params[:Body].downcase.split.map { |word| word.gsub(/[[:punct:]]/, '') }.join(' ')
  end

  def request_management(query, user)
    if query.split.first.casecmp?('wug')
      query = query.remove('wug ')
      user.update(last_request: query)
      service_responses = MessageManager.message(session[:track], query, user.language)
      session[:track] = service_responses[0]

      service_responses[1]
    elsif query.split.first.casecmp?('lyrics')
      query = query.remove('lyrics ')
      query = user.last_request if query == 'lyrics'
      session[:track] = nil

      GeniusLyrics.get_lyrics(query, user.language)
    end
  end
end
