require 'rails_helper'

RSpec.describe Business, type: :model do
  let(:user) { create(:user) }
  let(:business) { create(:business, user_id: user.id) }

  it "is valid with valid attributes" do
    expect(business).to be_valid
  end

  it "is not valid without name" do
    business.name = nil
    expect(business).to_not be_valid
  end

  it "is not valid without shares_available" do
    business.shares_available = nil
    expect(business).to_not be_valid
  end

  it "can not have negative shares_available" do
    expect { Business.create!(name: 'New test share', user_id: user.id, shares_available: -4) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "Associations" do
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:stock_trades) }
  end
end
