require 'rails_helper'

RSpec.describe Campaign, type: :model do
 describe "Associations" do
   it { should have_and_belong_to_many(:users) }
  end

  describe "Validations" do
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:message) }
  end
end
