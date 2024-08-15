class AccountMailer < ApplicationMailer
  def welcome_email(account, otp)
    @account = account
    @otp = otp
    # binding.pry
    mail(to: @account.email, subject: 'Welcome to Our App')
  end
end
