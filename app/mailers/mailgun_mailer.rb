# app/mailers/mailgun_mailer.rb
class MailgunMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def send_otp(email, otp)
    @otp = otp
    mail(to: email, subject: 'Your OTP Code')
  end
end
