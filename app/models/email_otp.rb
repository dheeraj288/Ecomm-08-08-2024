class EmailOtp < ApplicationRecord
  belongs_to :account
  validates :email, :valid_until, :activated, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "activated", "created_at", "email", "id", "id_value", "otp", "updated_at", "valid_until"]
  end
end
