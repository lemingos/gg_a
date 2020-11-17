require 'rails_helper'

RSpec.describe CampaignDeliveryService, type: :service do
  describe "#call" do
    let(:campaign) { FactoryBot.create(:campaign, :with_users) }
    let(:expected_arguments) do
      {
        :subject => campaign.subject,
        :body => campaign.message
      }
    end
    subject { CampaignDeliveryService.new(campaign) }

    it "should call 'Email::Message' with appropriate arguments" do
      expect(Email::Message).to receive(:new)
        .with(hash_including(expected_arguments))
        .exactly(3).times
        .and_return(OpenStruct.new(deliver: true))

      expect{subject.call}.to change{campaign.sent_at}
    end
  end
end
