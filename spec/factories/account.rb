FactoryBot.define do
  factory :account do
    email { 'user@example.com' }
    password { 'password' }
    full_phone_number { '+1234567890' }
  end
end
