# spec/factories/sub_categories.rb
FactoryBot.define do
  factory :sub_category do
    name { "SubCategory #{rand(1000)}" }
    category
  end
end
