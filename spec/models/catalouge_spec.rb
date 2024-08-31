require 'rails_helper'

RSpec.describe Catalogue, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should belong_to(:sub_category) }
    it { should belong_to(:brand) }
    it { should have_many(:catalogue_variants).dependent(:destroy) }
    it { should accept_nested_attributes_for(:catalogue_variants).allow_destroy(true) }
  end
  # describe 'validations' do
  #   it { should validate_presence_of(:name) }
  # end
end
