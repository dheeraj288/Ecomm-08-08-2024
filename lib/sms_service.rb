require 'twilio-ruby'

class SmsService
  def self.send_sms_otp(account)
    otp = generate_otp

    # Save the OTP to the database
    account.sms_otps.create!(
      otp: otp,
      valid_until: 10.minutes.from_now,
      activated: false
    )

    client = Twilio::REST::Client.new(twilio_sid, twilio_auth_token)
    client.messages.create(
      from: twilio_phone_number,
      to: account.full_phone_number,
      body: "Your OTP code is #{otp}"
    )
  end

  private

  def self.generate_otp
    rand(100000..999999).to_s
  end

  def self.twilio_sid
    Rails.application.credentials.dig(:twilio, :sid)
  end

  def self.twilio_auth_token
    Rails.application.credentials.dig(:twilio, :auth_token)
  end

  def self.twilio_phone_number
    Rails.application.credentials.dig(:twilio, :phone_number)
  end
end
