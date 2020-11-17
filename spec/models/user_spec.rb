require 'rails_helper'

RSpec.describe User, type: :model do
 describe "Associations" do
   it { should have_and_belong_to_many(:campaigns) }
  end

  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end
end
