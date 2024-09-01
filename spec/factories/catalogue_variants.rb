FactoryBot.define do
  factory :catalogue_variant do
    # name { "Sample Variant" }
    association :catalogue
    association :catalogue_variant_color
    association :catalogue_variant_size
    # Add other necessary attributes here
  end
end
