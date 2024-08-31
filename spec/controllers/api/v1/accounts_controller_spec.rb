# require 'rails_helper'

# RSpec.describe Api::V1::AccountsController, type: :controller do
#   let(:valid_signup_attributes) do
#   { email: 'test@example.com', password: 'password123', full_phone_number: '+1234567890' }
# end
#   let(:headers) { { 'Authorization' => "Bearer #{JsonWebToken.encode(account_id: account.id)}" } }

#   describe 'GET #index' do
#     before { request.headers.merge!(headers) }

#     it 'returns a successful response' do
#       get :index
#       expect(response).to have_http_status(:ok)
#       expect(JSON.parse(response.body)).not_to be_empty
#     end
#   end

#   describe 'POST #signup' do
#     context 'with valid parameters' do
#       it 'creates a new account and sends OTP via SMS' do
#         expect {
#           post :signup, params: { account: valid_signup_attributes }
#         }.to change(Account, :count).by(1)
        
#         expect(response).to have_http_status(:created)
#         expect(JSON.parse(response.body)['message']).to eq('Account created successfully. OTP sent via SMS')
#       end
#     end

#     context 'with invalid parameters' do
#       it 'returns unprocessable entity status' do
#         post :signup, params: { account: { email: 'invalid' } }
        
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(JSON.parse(response.body)['errors']).not_to be_empty
#       end
#     end
#   end

#   describe 'POST #send_email_otp' do
#     context 'when account exists' do
#       before do
#         allow_any_instance_of(Api::V1::AccountsController).to receive(:generate_otp).and_return(otp)
#         account
#       end

#       it 'sends OTP to email' do
#         expect {
#           post :send_email_otp, params: { email_otp: { email: account.email } }
#         }.to change(account.email_otps, :count).by(1)
        
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)['message']).to eq('OTP sent to email')
#       end
#     end

#     context 'when account does not exist' do
#       it 'returns not found status' do
#         post :send_email_otp, params: { email_otp: { email: 'nonexistent@example.com' } }
        
#         expect(response).to have_http_status(:not_found)
#         expect(JSON.parse(response.body)['error']).to eq('Account not found')
#       end
#     end
#   end

#   describe 'POST #send_sms_otp' do
#     context 'when account exists' do
#       before do
#         allow_any_instance_of(Api::V1::AccountsController).to receive(:generate_otp).and_return(otp)
#         account
#       end

#       it 'sends OTP via SMS' do
#         expect {
#           post :send_sms_otp, params: { sms_otp: { full_phone_number: account.full_phone_number } }
#         }.to change(account.sms_otps, :count).by(1)
        
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)['message']).to eq('OTP sent via SMS')
#       end
#     end

#     context 'when account does not exist' do
#       it 'returns not found status' do
#         post :send_sms_otp, params: { sms_otp: { full_phone_number: '+19999999999' } }
        
#         expect(response).to have_http_status(:not_found)
#         expect(JSON.parse(response.body)['error']).to eq('Account not found')
#       end
#     end
#   end

#   describe 'POST #login' do
#     context 'with valid OTP' do
#       before do
#         account.sms_otps.create!(otp: otp)
#       end

#       it 'logs in successfully with OTP' do
#         post :login, params: { account: { email: account.email, otp: otp } }
        
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)['message']).to eq('Login successful with OTP')
#         expect(JSON.parse(response.body)).to have_key('token')
#       end
#     end

#     context 'with invalid OTP' do
#       it 'returns unauthorized status' do
#         post :login, params: { account: { email: account.email, otp: 'invalid_otp' } }
        
#         expect(response).to have_http_status(:unauthorized)
#         expect(JSON.parse(response.body)['error']).to eq('Invalid OTP')
#       end
#     end

#     context 'with valid email and password' do
#       before do
#         account.update(password: 'password123')
#       end

#       it 'logs in successfully with email and password' do
#         post :login, params: { account: { email: account.email, password: 'password123' } }
        
#         expect(response).to have_http_status(:ok)
#         expect(JSON.parse(response.body)['message']).to eq('Login successful')
#         expect(JSON.parse(response.body)).to have_key('token')
#       end
#     end

#     context 'with invalid email or password' do
#       it 'returns unauthorized status' do
#         post :login, params: { account: { email: account.email, password: 'wrongpassword' } }
        
#         expect(response).to have_http_status(:unauthorized)
#         expect(JSON.parse(response.body)['error']).to eq('Invalid email or password')
#       end
#     end
#   end
# end
