class SmsOtp < ApplicationRecord
  belongs_to :account
  validates :full_phone_number, :valid_until, :activated, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "activated", "created_at", "full_phone_number", "id", "id_value", "otp", "updated_at", "valid_until"]
  end
end
