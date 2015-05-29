require './api/sendpulse_api'
require 'yaml'

API_CLIENT_ID = ''
API_CLIENT_SECRET = ''
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