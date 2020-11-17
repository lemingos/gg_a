require 'rails_helper'
require 'rspec/json_expectations'

RSpec.describe 'API V1 Campaigns', type: :request do

  describe '#post' do
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

    describe "valid params" do
      before(:each) { stub_request(:post, "https://api.sendgrid.com/v3/mail/send") }
      subject  { post '/api/v1/campaigns', params: valid_campaign_data }

      it { expect { subject }.to change { Campaign.count }.from(0).to(1) }
    end

    describe "invvalid params" do
      subject  {  post '/api/v1/campaigns', params: {} }

      it { expect { subject }.to change { Campaign.count }.by(0) }
    end

    describe 'validation errors' do
      let(:validation_error_json) do
        {
          'errors' => [
            {
              'source':{'pointer' => '/data/attributes/subject'},
              'detail' => "can't be blank"
            },
            {
              'source' => {'pointer' => '/data/attributes/message'},
              'detail' => "can't be blank"
            },
          ]
        }
      end

      subject do
        post '/api/v1/campaigns', params: {}
        response.body
      end

      it { expect(subject).to include_json(validation_error_json) }
    end
  end

  describe 'test user association' do
    before(:all) do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send")
      user = FactoryBot.create(:user)
      post "/api/v1/campaigns", params: {
        data: { attributes: { message: 'test', subject: 'test', recipients: [user.email] } }
      }
      @user = user.reload
    end

    subject { @user }

    it { expect(subject.campaign_count).to eql(1) }
    it { expect(subject.campaigns).to include(Campaign.last) }
  end

  describe 'valid response' do
    before(:all) do
      stub_request(:post, "https://api.sendgrid.com/v3/mail/send")
      @users = FactoryBot.create_list(:user, 10)

      post "/api/v1/campaigns", params: {
        data: { attributes: { message: 'test', subject: 'test', recipients: @users.map(&:email) } }
      }

      @response = response.body
    end

    let(:valid_response) do
      Campaign.last.as_json(only: [:id, :subject])
    end

    subject { @response }

    it { expect(subject).to include_json(valid_response) }
  end
end
