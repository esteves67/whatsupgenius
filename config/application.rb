# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whatsupgenius
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.use Rack::TwilioWebhookAuthentication, ENV['TWILIO_AUTH_TOKEN'], %r{/twilio/messages}
    config.sass.preferred_syntax = :sass
  end
end
