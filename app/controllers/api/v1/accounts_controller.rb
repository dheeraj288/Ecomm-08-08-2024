class Api::V1::AccountsController < ApplicationController
  before_action :authorize_request, except: [:signup, :send_sms_otp, :login]

  def index
    @accounts = Account.all
    render json: @accounts
  end

  def signup
    @account = Account.new(signup_params)

    if @account.save
      SmsService.send_sms_otp(@account)

      token = JsonWebToken.encode(account_id: @account.id)
      render json: { token: token, message: 'Account created successfully. OTP sent via SMS' }, status: :created
    else
      render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # def send_email_otp
  #   email_otp_params = params.require(:email_otp).permit(:email)
  #   @account = Account.find_by(email: email_otp_params[:email])

  #   if @account
  #     otp = generate_otp
  #     @account.email_otps.create!(otp: otp)

  #     # Correct method call for sending email OTP
  #     MailgunMailer.send_email_otp(@account.email, otp).deliver_now
  #     render json: { message: 'OTP sent to email' }, status: :ok
  #   else
  #     render json: { error: 'Account not found' }, status: :not_found
  #   end
  # end

  def send_sms_otp
    sms_otp_params = params.require(:sms_otp).permit(:full_phone_number)
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
    login_params = params.require(:account).permit(:email, :password, :otp)

    if login_params[:otp].present?
      @account = Account.find_by(email: login_params[:email])

      if @account && verify_otp(@account, login_params[:otp])
        token = JsonWebToken.encode(account_id: @account.id)
        render json: { token: token, message: 'Login successful with OTP' }, status: :ok
      else
        render json: { error: 'Invalid OTP' }, status: :unauthorized
      end
    else
      @account = Account.find_by(email: login_params[:email])

      if @account && @account.authenticate(login_params[:password])
        token = JsonWebToken.encode(account_id: @account.id)
        render json: { token: token, message: 'Login successful' }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end

  private

  def signup_params
    params.require(:account).permit(:email, :password, :full_phone_number, :first_name, :last_name, :country_code, :type)
  end

  def generate_otp
    rand(100000..999999).to_s
  end

  def verify_otp(account, otp)
    account.sms_otps.where(otp: otp).exists? || account.email_otps.where(otp: otp).exists?
  end
end
