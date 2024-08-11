class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :catalogue_variant

  after_create :process_transaction

  private

  def process_transaction
    if transaction_type == 'debit' && wallet.balance >= amount
      wallet.debit(amount)
      update(status: 'completed')
    elsif transaction_type == 'credit'
      wallet.credit(amount)
      update(status: 'completed')
    else
      update(status: 'failed')
    end
  end
  def self.ransackable_attributes(auth_object = nil)
    ["amount", "catalogue_variant_id", "created_at", "id", "id_value", "status", "transaction_type", "updated_at", "wallet_id"]
  end
   def self.ransackable_associations(auth_object = nil)
    ["catalogue_variant", "wallet"]
  end
end
