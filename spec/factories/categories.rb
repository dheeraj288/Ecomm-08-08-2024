# spec/factories/categories.rb
FactoryBot.define do
  factory :category do
    name { "Category #{rand(1000)}" }
    
    trait :with_sub_categories do
      after(:create) do |category|
        create_list(:sub_category, 3, category: category)
      end
    end
  end
end
