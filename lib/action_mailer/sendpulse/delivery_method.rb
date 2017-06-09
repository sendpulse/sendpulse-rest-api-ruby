require "digest/sha1"
begin
  require "mail"
  require "mail/check_delivery_params"
  require 'sendpulse-rest-api-ruby'
rescue LoadError
end

module Sendpulse
  class DeliveryMethod
    include Mail::CheckDeliveryParams if defined?(Mail::CheckDeliveryParams)

    class InvalidOption < StandardError; end

    attr_accessor :settings

    def initialize(options={})
      Sendpulse.configuration.options = options
      self.settings = Sendpulse.configuration
    end

    def deliver!(mail)
      check_delivery_params(mail) if respond_to?(:check_delivery_params)
      api_client_id = settings.api_client_id
      api_client_secret = settings.api_client_secret
      api_protocol = settings.api_protocol

      sendpulse_api = SendpulseApi.new(api_client_id, api_client_secret, api_protocol)

      email = {
          html: mail.html_part.decoded,
          text: mail.html_part.encoded,
          subject: mail.subject,
          from: { name: mail.from.first, email: mail.from_addrs.first },
          to: mail.to_addrs.map {|addrs| {name: addrs, email: addrs}},
          bcc: mail.bcc_addrs.map {|addrs| {name: addrs, email: addrs}}
      }

      result = sendpulse_api.smtp_send_mail(email)
      settings.logger.info("[sendpulse_api.smtp_send_mail] result:\n#{YAML::dump(result)}") if settings.logger
    end
  end
end
