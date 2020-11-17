module Email
  module Providers
    class Base

      attr_reader :email, :subject, :body

      def initialize(email:, subject:, body:)
        @email = email
        @subject = subject
        @body = body
      end
    end
  end
end
