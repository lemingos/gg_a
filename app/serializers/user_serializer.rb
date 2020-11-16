class UserSerializer < ActiveModel::Serializer
  attributes :email, :campaign_count, :id
end
