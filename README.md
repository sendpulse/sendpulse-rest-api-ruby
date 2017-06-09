# sendpulse-rest-api-ruby

A simple SendPulse REST client library and example for Ruby.

Includes a REST API and a Rails ActionMailer Delivery Method using the REST API.

## REST API Pre-requisites

Please activate REST API and obtain your API Client ID and Secret values by following these instructions:
- Login to login.sendpulse.com
- Go to Account Settings -> API tab
- Activate REST API (if not already activated).
- Copy and paste ID and Secret from there

## Setup Instructions

### Ruby without Bundler

Run the following command in your terminal:
```bash
gem install sendpulse-rest-api-ruby
```

Add the following require line to your ruby code:
```ruby
require 'sendpulse-rest-api-ruby'
```

### Rails or Ruby with Bundler

Add the following to `Gemfile`:
```ruby
gem 'sendpulse-rest-api-ruby'
```

Run the following command in your terminal:

```bash
bundle
```

Outside of Rails, you'd have to add a require line like the one in "Ruby without Bundler".

### Rails REST API Configuration

In Rails, you'd also have to configure the `API_CLIENT_ID` and `API_CLIENT_SECRET` variables at minimum.

It is recommended to do so by adding a Rails initializer as follows:
- Under `config/initializers`, create a file named `sendpulse_initializer.rb`
- Add the following code to it (entering the correct values):
```ruby
Sendpulse.configure do |config|
    config.api_client_id = 'apiclientidvalue'
    config.api_client_secret = 'apiclientsecretvalue'
end
```

For use with Heroku, it is recommended you configure Rails initializer via environment variables as follows:

```ruby
Sendpulse.configure do |config|
    config.api_client_id = ENV['SENDPULSE_API_CLIENT_ID']
    config.api_client_secret = ENV['SENDPULSE_API_CLIENT_SECRET']
end
```

Then run the following command to configure these environment variables in Heroku:
```bash
heroku config:add SENDPULSE_API_CLIENT_ID=apiclientidvalue SENDPULSE_API_CLIENT_SECRET=apiclientsecretvalue
```

### Rails ActionMailer Delivery Method Configuration

This depends on Rails REST API Configuration being done.

Simply set your `config.action_mailer.delivery_method` to `:sendpulse` in your environment config file.

For example, you can add the following to `config/environments/production.rb` for production's deployment:
```ruby
config.action_mailer.delivery_method = :sendpulse
```

## API Example

```ruby
require 'sendpulse-rest-api-ruby'
require 'yaml'

API_CLIENT_ID = 'apiclientidvalue'
API_CLIENT_SECRET = 'apiclientsecretvalue'
API_PROTOCOL = 'https'
API_TOKEN = ''

sendpulse_api = SendpulseApi.new(API_CLIENT_ID, API_CLIENT_SECRET, API_PROTOCOL, API_TOKEN)

result = sendpulse_api.get_token
YAML::dump(result)

result = sendpulse_api.create_campaign('Name', 'example@gmail.com', 'Example subject', '<html><b>Example</b></html>', 'book_id') #+
YAML::dump(result)

result = sendpulse_api.add_sender('Some name', 'example@gmail.com')
YAML::dump(result)

result = sendpulse_api.get_balance
YAML::dump(result)

email = {
    html: '<html><body><H1>TEXT</H1></body></html>',
    text: 'TEST',
    subject: 'Test, test test test',
    from: { name: 'some', email: 'example@gmail.com' },
    to: [
        { name: 'some1', email: 'example1@gmail.com' },
        { name: 'some3', email: 'example3@divermail.com' },
    ],
    bcc: [{ name: 'some2', email: 'example2@gmail.com' }]
}

result = sendpulse_api.smtp_send_mail(email)
YAML::dump(result)
```

## License

Apache License  
Version 2.0, January 2004  
http://www.apache.org/licenses/  
Copyright 2015 SendPulse  
See `LICENSE` for more details.
