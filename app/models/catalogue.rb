class Catalogue < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand

  has_many :catalogue_variants

  validates :name, :description, :category_id, :sub_category_id, :brand_id, presence: true
end
