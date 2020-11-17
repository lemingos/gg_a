require 'mailgun-ruby'

module Email
  module Providers
    class Mailgun < Email::Providers::Base

      include SendGrid

      def deliver
        client.send_message 'sending_domain.com', message_params
      end

      private

      def client
        @client ||= Mailgun::Client.new ENV['MAILGUN_API_KEY']
      end

      def message_params
        {
          from: ::Email::Message::From,
          to: email,
          subject: subject,
          text: body
        }
      end

    end
  end
end


