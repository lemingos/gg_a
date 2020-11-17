FactoryBot.define do
  factory :campaign do
    subject { "MyString" }
    message { "MyText" }

    trait :with_users do
      transient do
        count { 3 }
      end

      after(:create) do |campaign, e|
        campaign.users << create_list(:user, e.count)
      end
    end
  end
end
