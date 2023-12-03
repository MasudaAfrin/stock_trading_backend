class AddUserIdBusiness < ActiveRecord::Migration[7.0]
  def change
    add_reference :businesses, :user, foreign_key: true, null: false
  end
end
