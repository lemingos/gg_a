class Api::V1::CampaignsController < Api::ApplicationController
  private

  def resource_class
    Campaign
  end

  def resource_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      params, only: [:subject, :message, :recipients],
      keys: { recipients: :users  }
    )
  end
end
