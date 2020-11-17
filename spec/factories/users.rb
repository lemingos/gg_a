FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    campaign_count { 0 }

    trait :with_campaign do
      after(:create) do |user, _|
        user.campaigns << create(:campaign)
      end
    end

    trait :with_campaigns do
      transient do
        count { 3 }
      end
      before(:create) do |user, e|
        user.campaigns << create_list(:campaign, e.count, users: [user])
      end
    end
  end
end
