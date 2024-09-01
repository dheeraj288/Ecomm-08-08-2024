require 'rails_helper'

RSpec.describe CatalogueVariant, type: :model do
  describe 'associations' do
    it { should belong_to(:catalogue) }
    it { should belong_to(:catalogue_variant_color) }
    it { should belong_to(:catalogue_variant_size) }
    it { should accept_nested_attributes_for(:catalogue_variant_color).allow_destroy(true) }
    it { should accept_nested_attributes_for(:catalogue_variant_size).allow_destroy(true) }
  end
end
