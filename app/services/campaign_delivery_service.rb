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

    campaign.users.each do |user|
      Email::Message.new(
        email: user.email,
        subject: campaign.subject,
        body: campaign.message
      ).deliver
    end
  end
end
