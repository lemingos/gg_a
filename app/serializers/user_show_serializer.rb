class UserShowSerializer < ActiveModel::Serializer
  attributes :email, :campaign_count, :id
  has_many :campaigns, serializer: CampaignShowSerializer
end
