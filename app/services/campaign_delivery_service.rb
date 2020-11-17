class CampaignDeliveryService
  attr_reader :campaign

  def initialize(campaign)
    @campaign = campaign
  end

  def call
    deliver_campaign
  end

  def deliver_campaign
    # This is simplified version not taking into account large amounts of users
    # for that case would need to process in batches with background jobs or external service
    # dedicated for that purpose

    # In this example we send 1 email per 1 user that give more flexibility over email content.
    # Other approach would be to use batch email described here:
    # https://github.com/mailgun/mailgun-ruby/blob/master/docs/MessageBuilder.md
    # Useful when no message customization needed and with high user volumes
    # For eg:
    #
    #  Email::BatchMessage.new(recipients: campaign.users, subject: campaign.subject, body: campagin.body)
    #
    # or with combination with find_each

    campaign.users.each do |user|
      Email::Message.new(
        email: user.email,
        subject: campaign.subject,
        body: campaign.message
      ).deliver
    end

    campaign.touch(:sent_at)
  end
end
