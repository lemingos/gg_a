module Email
  class Message
    FROM = 'test@example.com'

    def initialize(attributes)
      @retry_count = 0
      @attributes = attributes
    end

    def provider
      if @retry_count.even?
        Email::Providers::Sendgrid
      else
        Email::Providers::Sendgrid
      end
    end

    def deliver
      provider.new(@attributes).deliver
    # rescue
    #   @retry_count += 1
    #   retry
    end
  end
end
