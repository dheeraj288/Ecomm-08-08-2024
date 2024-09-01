# spec/factories/catalogue_variant_colors.rb
FactoryBot.define do
  factory :catalogue_variant_color do
    name { "Red" }
    color { "#FF0000" }  # Assuming color is a hex code or similar
  end
end
