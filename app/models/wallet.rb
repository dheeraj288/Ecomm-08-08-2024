class Wallet < ApplicationRecord
  belongs_to :account
  has_many :transactions, dependent: :destroy

  # Method to credit balance
  def credit(amount)
    update(balance: balance + amount)
  end

  # Method to debit balance
  def debit(amount)
    update(balance: balance - amount)
  end

  def self.ransackable_associations(auth_object = nil)
    ["account", "transactions"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["account_id", "balance", "created_at", "id", "id_value", "updated_at"]
  end
end