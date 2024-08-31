class CatalogueVariant < ApplicationRecord
  belongs_to :catalogue
  belongs_to :catalogue_variant_color
  belongs_to :catalogue_variant_size
  accepts_nested_attributes_for :catalogue_variant_color, allow_destroy: true
  accepts_nested_attributes_for :catalogue_variant_size, allow_destroy: true

  validates :name, presence: true
  validates :price, presence: true

  
  def self.ransackable_attributes(auth_object = nil)
    ["catalogue_id", "catalogue_variant_color_id", "catalogue_variant_size_id", "created_at", "id", "id_value", "updated_at"]
  end
   def self.ransackable_associations(auth_object = nil)
    ["catalogue", "catalogue_variant_color", "catalogue_variant_size"]
  end
end