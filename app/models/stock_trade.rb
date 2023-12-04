class StockTrade < ApplicationRecord
  # association
  belongs_to :business
  belongs_to :buyer, class_name: 'User', foreign_key: :buyer_id

  # enum
  enum trade_status: { requested: 0, accepted: 1, rejected: 2 }

  # validation
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence:true, numericality: { greater_than_or_equal_to: 1 }
  validate :share_quantity, if: :should_validate?

  # callback
  after_update :update_available_share, if: :accepted?

  private

  def should_validate?
    return true if new_record?

    self.accepted? ? true : false
  end

  def share_quantity
    available_share = business.shares_available
    if quantity > available_share
      errors.add(:quantity, "can't be greater than available shares!")
    end
  end

  def update_available_share
    current_share = business.shares_available
    updated_share = current_share - self.quantity
    business.update_columns(shares_available: updated_share)
  end
end
