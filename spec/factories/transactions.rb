FactoryBot.define do
  factory :transaction do
    wallet
    amount { 50.0 }
    transaction_type { 'debit' }
    status { 'completed' }
    catalogue_variant
  end
end