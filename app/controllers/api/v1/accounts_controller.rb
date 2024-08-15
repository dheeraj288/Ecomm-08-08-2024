class Api::V1::AccountsController < ApplicationController
before_action :authorize_request, except: [:signup, :send_email_otp, :login]

  def index
    render json: Account.all
  end

  def signup
  @account = Account.new(signup_params)

  if @account.save
    otp = generate_otp
    @account.sms_otps.create!(otp: otp)
    
    AccountMailer.welcome_email(@account, otp).deliver_now

    SmsService.send_sms_otp(@account)

    token = JsonWebToken.encode(account_id: @account.id)
    render json: { token: token, message: 'Account created successfully. OTP sent via SMS and email' }, status: :created
  else
    render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
  end
end

  def send_email_otp
    @account = Account.find_by(email: email_otp_params[:email])

    if @account
      otp = generate_otp
      @account.email_otps.create!(otp: otp)
      MailgunMailer.send_email_otp(@account.email, otp).deliver_now
      render json: { message: 'OTP sent to email' }, status: :ok
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end

  def send_sms_otp
    @account = Account.find_by(full_phone_number: sms_otp_params[:full_phone_number])

    if @account
      otp = generate_otp
      @account.sms_otps.create!(otp: otp)
      SmsService.send_sms_otp(@account)
      render json: { message: 'OTP sent via SMS' }, status: :ok
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end

  def login
    @account = Account.find_by(email: login_params[:email])

    if @account && valid_login?(@account)
      token = JsonWebToken.encode(account_id: @account.id)
      message = login_params[:otp].present? ? 'Login successful with OTP' : 'Login successful'
      render json: { token: token, message: message }, status: :ok
    else
      render json: { error: 'Invalid email, password, or OTP' }, status: :unauthorized
    end
  end

  private

  def signup_params
    params.require(:account).permit(:email, :password, :full_phone_number, :first_name, :last_name, :country_code, :type)
  end

  def email_otp_params
    params.require(:email_otp).permit(:email)
  end

  def sms_otp_params
    params.require(:sms_otp).permit(:full_phone_number)
  end

  def login_params
    params.require(:account).permit(:email, :password, :otp)
  end

  def generate_otp
    rand(100000..999999).to_s
  end

  def send_welcome_email(account)
    AccountMailer.welcome_email(account).deliver_now
  end

  def send_sms_otp(account)
    SmsService.send_sms_otp(account)
  end

  def valid_login?(account)
    login_params[:otp].present? ? verify_otp(account, login_params[:otp]) : account.authenticate(login_params[:password])
  end

  def verify_otp(account, otp)
    account.sms_otps.where(otp: otp).exists? || account.email_otps.where(otp: otp).exists?
  end
end
