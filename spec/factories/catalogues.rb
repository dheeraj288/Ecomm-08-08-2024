FactoryBot.define do
  factory :catalogue do
    name { "Sample Catalogue" }
    description { "This is a sample catalogue." }
    association :category
    association :sub_category
    association :brand
  end
end