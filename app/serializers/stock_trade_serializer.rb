class StockTradeSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :price, :business, :buyer, :created_at, :trade_status

  def business
    object.business.name
  end

  def buyer
    object.buyer.name
  end
end
