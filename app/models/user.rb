class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token :auth_token, length: 30

  # Association
  has_many :businesses
  has_many :stock_trades, foreign_key: :buyer_id
  has_many :stock_requests, through: :businesses, source: :stock_trades

  # validation
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                               message: 'Please provide valid email' }
end
