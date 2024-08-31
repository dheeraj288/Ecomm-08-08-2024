# spec/models/account_spec.rb
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:full_phone_number) }
  end

  describe 'associations' do
    it { should have_many(:email_otps) }
    it { should have_many(:sms_otps) }
    it { should have_one(:wallet).dependent(:destroy) }
  end
end
