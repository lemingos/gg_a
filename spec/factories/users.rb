FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    campaign_count { 0 }
  end
end
