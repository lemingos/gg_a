class Api::V1::CampaignsController < Api::ApplicationController

  private

  def create_callback
    resource.increase_user_campaign_counters!
    CampaignDeliveryService.new(resource).call
  end

  def resource_class
    Campaign
  end

  def show_serializer
    CampaignShowSerializer
  end

  def resource_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: [:subject, :message, :recipients],
      keys: { recipients: :users  }
    )
  end
end
