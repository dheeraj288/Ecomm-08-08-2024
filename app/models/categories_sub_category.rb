class CategoriesSubCategory < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category

  validates :category_id, :sub_category_id, presence: true
end
