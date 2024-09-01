require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  let(:valid_attributes) {
    { email: 'test@example.com', password: 'password123', full_phone_number: '+1234567890' }
  }
  let(:invalid_attributes) {
    { email: '', password: '', full_phone_number: '' }
  }

  describe "POST #signup" do
    it "creates a new Account" do
      expect {
        post :signup, params: { account: valid_attributes }
      }.to change(Account, :count).by(1)
    end

    it "sends an SMS OTP" do
      post :signup, params: { account: valid_attributes }
      expect(response).to have_http_status(:created)
    end

    it "returns a token and success message" do
      post :signup, params: { account: valid_attributes }
      expect(response).to have_http_status(:created)
    end

    it "does not create a new Account with invalid parameters" do
      expect {
        post :signup, params: { account: invalid_attributes }
      }.to change(Account, :count).by(0)
    end

    it "returns errors with invalid parameters" do
      post :signup, params: { account: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "POST #send_sms_otp" do
    let!(:account) { Account.create!(valid_attributes) }

    it "generates and sends an OTP when account exists" do
      post :send_sms_otp, params: { sms_otp: { full_phone_number: account.full_phone_number } }
      expect(response).to have_http_status(:ok)
    end

    it "returns an error when account does not exist" do
      post :send_sms_otp, params: { sms_otp: { full_phone_number: 'nonexistent' } }
      expect(response).to have_http_status(:not_found)
    end
  end
end
