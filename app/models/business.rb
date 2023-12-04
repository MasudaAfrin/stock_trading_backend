class Business < ApplicationRecord
  # Association
  belongs_to :user

  validates :name, :shares_available, presence: true
  validates :shares_available, :numericality => { :greater_than_or_equal_to => 0 }

  scope :available_shares, -> (current_user)  { where.not(user_id: current_user.id) }
end
