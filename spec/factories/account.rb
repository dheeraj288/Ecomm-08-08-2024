FactoryBot.define do
  factory :account do
    email { "test@example.com" }
    password { "password123" }
    full_phone_number { "+1234567890" }
  end
end
