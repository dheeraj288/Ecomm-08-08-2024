class Category < ApplicationRecord
  has_many :sub_categories
  has_many :categories_sub_categories
  has_many :sub_categories, through: :categories_sub_categories

  validates :name, presence: true
	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["sub_categories"]
  end
end

