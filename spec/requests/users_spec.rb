require 'rails_helper'
require 'rspec/json_expectations'

RSpec.describe 'API V1 Users', type: :request do

  describe '#index' do
    let(:users) do
      FactoryBot.create_list(:user, 10, :with_campaign)
    end

    let :valid_response do
      User.all.map {|u| UserSerializer.new(u).as_json }
    end

    describe "valid params" do
      subject do
        get '/api/v1/users'
        response.body
      end

      it { expect(subject).to include_json(valid_response) }
    end
  end

  describe '#show' do
    let(:user) do
      FactoryBot.create(:user, :with_campaigns, count: 5)
    end

    let :valid_response do
      UserSerializer.new(User.last).as_json
    end

    describe "valid params" do
      subject do
        get "/api/v1/users/#{user.id}"
        response.body
      end

      it { expect(subject).to include_json(valid_response) }
    end
  end
end
