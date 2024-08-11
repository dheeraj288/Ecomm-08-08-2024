class Api::V1::AccountsController < ApplicationController
   before_action :authorize_request, except: :login

   def index
   	@account = Account.all
   	render json: @account
   end

  def signup
    @account = Account.new(signup_params)

    if @account.save
      # Optionally, you can send an OTP after signup for email/phone verification
      # send_otp_to_user(@account) 

      token = JsonWebToken.encode(account_id: @account.id)
      render json: { token: token, message: 'Account created successfully' }, status: :created
    else
      render json: { errors: @account.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def login
  account_params = params.require(:account).permit(:email, :password)
  @account = Account.find_by(email: account_params[:email])

  if @account&.authenticate(account_params[:password])
    token = JsonWebToken.encode(account_id: @account.id)
    render json: { token: token }, status: :ok
  else
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end
end



   def send_email_otp
    @account = Account.find_by(email: params[:email])

    if @account
      otp_code = rand(100000..999999).to_s
      @account.email_otps.create!(otp_code: otp_code)

      # Send email using Mailgun
      MailgunMailer.send_otp(@account.email, otp_code).deliver_now
      render json: { message: 'OTP sent to email' }, status: :ok
    else
      render json: { error: 'account not found' }, status: :not_found
    end
  end


  def send_sms_otp
    @account = Account.find_by(phone: params[:phone])

    if @account
      otp_code = rand(100000..999999).to_s
      @account.sms_otps.create!(otp_code: otp_code)

      # Send SMS using Twilio
      client = Twilio::REST::Client.new(account_sid, auth_token)
      client.messages.create(
        from: '+1234567890', # Your Twilio number
        to: @account.phone,
        body: "Your OTP code is #{otp_code}"
      )
      render json: { message: 'OTP sent via SMS' }, status: :ok
    else
      render json: { error: 'account not found' }, status: :not_found
    end
  end

  private

  def signup_params
    params.require(:account).permit(
       :email,
       :password,
       :first_name,
       :last_name,
       :full_phone_number,
       :country_code,
       :phone_number,
       :type,
    )
  end
end


# a = Account.new(email:"harry@example.com", password:"123456", first_name:"harry", last_name:"potter", full_phone_number:"8447119553", country_code:"+91", type:"email_otp")