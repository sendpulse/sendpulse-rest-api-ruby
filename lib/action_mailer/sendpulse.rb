module Sendpulse

  def self.configuration
    @configration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

require_relative 'sendpulse/configuration'
require_relative 'sendpulse/delivery_method'
require_relative 'sendpulse/message'
require_relative 'sendpulse/railtie' if defined?(Rails::Railtie)
