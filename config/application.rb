# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Whatsupgenius
  class Application < Rails::Application
    config.load_defaults 6.0

    config.middleware.use(
      Rack::TwilioWebhookAuthentication,
      Rails.application.credentials.twilio[:auth_token], %r{/twilio/messages}
    )

    config.sass.preferred_syntax = :sass
  end
end
