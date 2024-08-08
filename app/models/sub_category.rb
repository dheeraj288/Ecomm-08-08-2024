class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :categories_sub_categories
  has_many :categories, through: :categories_sub_categories

  validates :name, :category_id, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "id_value", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end

