class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token :auth_token, length: 30
end
