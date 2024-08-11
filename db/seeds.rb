# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
 AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?



5.times do
  Brand.create!(
    name: Faker::Company.name
  )
end

5.times do
  category = Category.create!(
    name: Faker::Commerce.department
  )
  
  3.times do
    SubCategory.create!(
      name: Faker::Commerce.material,
      category_id: category.id
    )
  end
end

10.times do
  Catalogue.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentence,
    category_id: Category.pluck(:id).sample,
    sub_category_id: SubCategory.pluck(:id).sample,
    brand_id: Brand.pluck(:id).sample
  )
end

5.times do
  color = CatalogueVariantColor.create!(
    name: Faker::Color.color_name,
    color: Faker::Color.hex_color
  )
  
  size = CatalogueVariantSize.create!(
    name: ["Small", "Medium", "Large", "Extra Large"].sample,
    size: ["S", "M", "L", "XL"].sample
  )
  
  10.times do
    CatalogueVariant.create!(
      catalogue_id: Catalogue.pluck(:id).sample,
      catalogue_variant_color_id: color.id,
      catalogue_variant_size_id: size.id
    )
  end
end

Account.all.each do |account|
  wallet = Wallet.create!(
    account_id: account.id,
    balance: Faker::Commerce.price(range: 100.0..1000.0)
  )

  5.times do
    Transaction.create!(
      wallet_id: wallet.id,
      catalogue_variant_id: CatalogueVariant.pluck(:id).sample,
      amount: Faker::Commerce.price(range: 10.0..100.0),
      transaction_type: ["debit", "credit"].sample,
      status: ["pending", "completed", "failed"].sample
    )
  end
end

puts "Seeding completed!"
