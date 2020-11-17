require 'mailgun-ruby'

module Email
  module Providers
    class MailgunProvider < Email::Providers::Base

      def deliver
        response = client.send_message ENV['MAILGUN_DOMAIN'], message_params
        raise ApiError unless response.code.to_s =~ /20\d/
      rescue Mailgun::CommunicationError
        raise ApiError
      end

      private

      def client
        @client ||= ::Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
      end

      def message_params
        {
          from: ::Email::Message::FROM,
          to: email,
          subject: subject,
          text: body
        }
      end
    end
  end
end


