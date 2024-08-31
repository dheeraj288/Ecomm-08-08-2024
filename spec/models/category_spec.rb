require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:sub_categories).dependent(:destroy) }
    it { should accept_nested_attributes_for(:sub_categories).allow_destroy(true) }
  end

  describe 'nested attributes' do
    it 'rejects sub_categories with all blank attributes' do
      category = Category.new(name: 'Sample Category')
      category.sub_categories_attributes = [{ name: '' }]

      expect(category.sub_categories).to be_empty

      category.save

      expect(category.sub_categories).to be_empty
    end
  end
end
