class CampaignSerializer < ActiveModel::Serializer
  attributes :subject, :message, :users
  has_many :users
end
