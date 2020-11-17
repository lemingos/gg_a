require 'sendgrid-ruby'

module Email
  module Providers
    class Sendgrid < Email::Providers::Base

      include SendGrid

      def deliver
        client.mail._('send').post(request_body: mail.to_json)
      end

      private

      def client
        SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
      end

      def mail
        Mail.new(from, subject, to, content)
      end

      def from
        Email.new(email: ::Email::Message::FROM)
      end

      def to
        Email.new(email: email)
      end

      def content
        Content.new(type: 'text/plain', value: body)
      end
    end
  end
end


