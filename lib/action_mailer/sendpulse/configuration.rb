module Sendpulse
  class Configuration
    attr_accessor :api_client_id, :api_client_secret, :api_protocol, :options, :logger

    def initialize
      @api_protocol = 'https'
      @logger = Rails.logger if defined?(Rails)
    end
  end
end
