require 'rails_helper'

RSpec.describe StockTrade, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'test_user@second.com') }
  let(:business) { create(:business, user_id: user.id) }
  let(:stock_trade) { create(:stock_trade, business_id: business.id, buyer_id: user2.id) }

  describe "Associations" do
    it { should belong_to(:business).without_validating_presence }
    it { should belong_to(:buyer).without_validating_presence }
  end

  it "is valid with valid attributes" do
    expect(stock_trade).to be_valid
  end

  it "can not have negative price" do
    expect { StockTrade.create!(price: -40.00, quantity: 1, buyer_id: user2.id, business_id: business.id) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "can not have quantity less than 1" do
    expect { StockTrade.create!(price: 40.00, quantity: 0, buyer_id: user2.id, business_id: business.id) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "can not have greater quantity than business available shares" do
    expect { StockTrade.create!(price: 40.00, quantity: 20, buyer_id: user2.id, business_id: business.id) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "can not accept a share if quantity is greater than business available shares" do
    stock = StockTrade.create!(price: 40.00, quantity: 5, buyer_id: user2.id, business_id: business.id)
    stock.business.update!(shares_available: 3)
    expect { stock.reload.update!(trade_status: :accepted) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
