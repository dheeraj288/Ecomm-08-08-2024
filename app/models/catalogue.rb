class Catalogue < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  belongs_to :brand
  has_many :catalogue_variants, dependent: :destroy

    accepts_nested_attributes_for :catalogue_variants


  def self.ransackable_associations(auth_object = nil)
    ["brand", "catalogue_variants", "category", "sub_category"]
  end
  def self.ransackable_attributes(auth_object = nil)
    ["brand_id", "category_id", "created_at", "description", "id", "id_value", "name", "sub_category_id", "updated_at"]
  end
end