class Account < ApplicationRecord
  has_secure_password
  has_many :email_otps
  has_many :sms_otps

  has_one :wallet, dependent: :destroy
  after_create :create_wallet

  validates :full_phone_number, presence: true

  after_create :send_otp

	def send_otp
		if type == "EmailAccount"
			email_otp = EmailOtp.new(email: email)
			email_otp.save

		elsif type == "SmsAccount"
			sms_otp = SmsOtp.new(full_phone_number: full_phone_number)
			sms_otp.save
		end 
	end
	def self.ransackable_associations(auth_object = nil)
    ["email_otps", "sms_otps", "wallet"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["country_code", "created_at", "email", "first_name", "full_phone_number", "id", "id_value", "last_name", "password_digest", "phone_number", "type", "updated_at"]
  end
end
