# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# db/seeds.rb

# Clear existing data
# CatalogueVariant.destroy_all
# Catalogue.destroy_all
# SubCategory.destroy_all
# Category.destroy_all
# Brand.destroy_all
# CatalogueVariantColor.destroy_all
# CatalogueVariantSize.destroy_all

# Create some categories, subcategories, and brands

category = Category.create!(name: 'Watches')
sub_category = SubCategory.create!(name: 'Smart Watches', category: category)
brand = Brand.create!(name: 'Apple')

# Create some variant colors and sizes
color1 = CatalogueVariantColor.create!(name: 'Black')
color2 = CatalogueVariantColor.create!(name: 'White')
size1 = CatalogueVariantSize.create!(name: 'Small')
size2 = CatalogueVariantSize.create!(name: 'Large')

# Create some catalogues with variants
catalogue1 = Catalogue.create!(
  name: 'Apple Watch Series 7',
  description: 'Latest Apple Watch with advanced features',
  category: category,
  sub_category: sub_category,
  brand: brand,
  catalogue_variants_attributes: [
    { catalogue_variant_color_id: color1.id, catalogue_variant_size_id: size1.id },
    { catalogue_variant_color_id: color2.id, catalogue_variant_size_id: size2.id }
  ]
)

catalogue2 = Catalogue.create!(
  name: 'Apple Watch SE',
  description: 'Affordable Apple Watch with essential features',
  category: category,
  sub_category: sub_category,
  brand: brand,
  catalogue_variants_attributes: [
    { catalogue_variant_color_id: color1.id, catalogue_variant_size_id: size2.id }
  ]
)
