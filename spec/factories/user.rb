FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "johntest@stock.com" }
    password { "John@12345" }
    auth_token { "fjhdjh1323223232" }
  end
end
