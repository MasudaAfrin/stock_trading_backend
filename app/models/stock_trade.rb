class StockTrade < ApplicationRecord
  # association
  belongs_to :business
  belongs_to :buyer, class_name: 'User', foreign_key: :buyer_id

  # enum
  enum trade_status: { requested: 0, accepted: 1, rejected: 2 }

  # validation
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence:true, numericality: { greater_than_or_equal_to: 1 }
end
