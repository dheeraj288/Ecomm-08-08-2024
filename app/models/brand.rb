class Brand < ApplicationRecord
  has_many :catalogues

  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["catalogues"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
end
