module Sendpulse
  class Railtie < Rails::Railtie
    initializer "sendpulse.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method(
          :sendpulse,
          Sendpulse::DeliveryMethod
        )
      end
    end
  end
end
