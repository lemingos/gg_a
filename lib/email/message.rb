module Email
  class Message
    FROM = 'test@example.com'
    PROVIDERS = %w(SendgridProvider MailgunProvider).freeze

    def initialize(attributes)
      @retry_count = 0
      @attributes = attributes
    end

    def deliver
      provider_class.new(@attributes).deliver
    rescue ApiError => e
      @retry_count += 1

      if @retry_count < PROVIDERS.size
        retry
      else
        raise ApiError, 'message not delivered'
      end
    end

    def provider_class
      "Email::Providers::#{provider_name}".constantize
    end

    def provider_name
      PROVIDERS[@retry_count.modulo(PROVIDERS.size)]
    end
  end
end
