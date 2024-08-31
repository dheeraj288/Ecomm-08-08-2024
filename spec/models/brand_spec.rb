# spec/models/brand_spec.rb
require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'associations' do
    it { should have_many(:catalogues) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
