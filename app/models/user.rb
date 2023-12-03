class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token :auth_token, length: 30

  # Association
  has_many :businesses

  # validation
  validates :name, :email, presence: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP,
                                               message: 'Please provide valid email' }
end
