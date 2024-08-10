class CatalogueVariant < ApplicationRecord
  belongs_to :catalogue
  belongs_to :catalogue_variant_color
  belongs_to :catalogue_variant_size

  
  def self.ransackable_attributes(auth_object = nil)
    ["catalogue_id", "catalogue_variant_color_id", "catalogue_variant_size_id", "created_at", "id", "id_value", "updated_at"]
  end
   def self.ransackable_associations(auth_object = nil)
    ["catalogue", "catalogue_variant_color", "catalogue_variant_size"]
  end
end