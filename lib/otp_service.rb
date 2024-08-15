class OtpService
  def self.send_email_otp(account)
    otp = rand(100000..999999).to_s
    account.email_otps.create!(otp: otp)
    MailgunMailer.send_otp(account.email, otp).deliver_now
  end

  def self.send_sms_otp(account)
    otp = rand(100000..999999).to_s
    account.sms_otps.create!(otp: otp)

    client = Twilio::REST::Client.new(TWILIO_SID, TWILIO_AUTH_TOKEN)
    client.messages.create(
      from: TWILIO_PHONE_NUMBER,
      to: account.full_phone_number,
      body: "Your OTP code is #{otp}"
    )
  end
end
