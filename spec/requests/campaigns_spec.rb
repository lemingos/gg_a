require 'rails_helper'
require 'rspec/json_expectations'

RSpec.describe 'API V1 Campaigns', type: :request do

  let(:users) { FactoryBot.create_list(:user, 10) }
  let :valid_campaign_data do
    {
      data: {
        attributes: {
          subject: 'New Campaign',
          message: 'This is great!',
          recipients: users.map(&:email)
        }
      }
    }
  end

  it 'creates campaign' do
    users
    expect do
      post '/api/v1/campaigns', params: valid_campaign_data
    end
      .to change { User.count }.by(0)
      .and change { Campaign.count }.by(1)
  end

  it 'should raise campaign validation' do
    expect do
      post '/api/v1/campaigns', params: {}
    end
      .to change { Campaign.count }.by(0)
      .and change { User.count }.by(0)

    expect(response.body).to include_json(
      { 'errors' => [
        {'source' => {'pointer' => '/data/attributes/subject'}, 'detail' => "can't be blank"},
        {'source' => {'pointer' => '/data/attributes/message'}, 'detail' => "can't be blank"},
      ] }
    )
  end

  describe 'test association' do
    let(:user) { FactoryBot.create(:user) }

    it 'records association properly' do
      post "/api/v1/campaigns", params: {data: { attributes: { message: 'test', subject: 'test', recipients: [user.email] } } }
      user.reload
      expect(user.campaign_count).to eql(1)
      expect(user.campaigns).to include(Campaign.last)
    end
  end
end
