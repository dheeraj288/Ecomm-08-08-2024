class SmsOtp < ApplicationRecord
  validates :full_phone_number, :valid_until, :activated, presence: true
end
