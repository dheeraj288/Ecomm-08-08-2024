require 'rails_helper'

RSpec.describe CatalogueVariant, type: :model do
  describe 'associations' do
    it { should belong_to(:catalogue) }
    it { should belong_to(:catalogue_variant_color) }
    it { should belong_to(:catalogue_variant_size) }
    it { should accept_nested_attributes_for(:catalogue_variant_color).allow_destroy(true) }
    it { should accept_nested_attributes_for(:catalogue_variant_size).allow_destroy(true) }
  end

  describe 'nested attributes' do
    let(:category) { Category.create!(name: 'Sample Category') }
    let(:sub_category) { SubCategory.create!(name: 'Sample SubCategory', category: category) }
    let(:brand) { Brand.create!(name: 'Sample Brand') }
    let(:color) { CatalogueVariantColor.create!(color_name: 'Red') }
    let(:size) { CatalogueVariantSize.create!(size_name: 'M') }
    let(:catalogue) { Catalogue.create!(name: 'Sample Catalogue', category: category, sub_category: sub_category, brand: brand) }

    it 'allows nested attributes for catalogue_variant_color and catalogue_variant_size' do
      variant = catalogue.catalogue_variants.create!(
        name: 'Variant 1',
        price: 100,
        catalogue_variant_color_attributes: { color_name: 'Red' },
        catalogue_variant_size_attributes: { size_name: 'M' }
      )

      expect(variant.catalogue_variant_color.color_name).to eq('Red')
      expect(variant.catalogue_variant_size.size_name).to eq('M')
    end

    it 'destroys nested catalogue_variant_color if allow_destroy is true' do
      variant = catalogue.catalogue_variants.create!(
        name: 'Variant 1',
        price: 100,
        catalogue_variant_color: color,
        catalogue_variant_size: size
      )

      variant.update(catalogue_variant_color_attributes: { id: color.id, _destroy: '1' })
      variant.reload

      expect(variant.catalogue_variant_color).to be_nil
    end

    it 'destroys nested catalogue_variant_size if allow_destroy is true' do
      variant = catalogue.catalogue_variants.create!(
        name: 'Variant 1',
        price: 100,
        catalogue_variant_color: color,
        catalogue_variant_size: size
      )

      variant.update(catalogue_variant_size_attributes: { id: size.id, _destroy: '1' })
      variant.reload

      expect(variant.catalogue_variant_size).to be_nil
    end
  end
end
