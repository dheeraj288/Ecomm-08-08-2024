class CatalogueVariantSize < ApplicationRecord
  has_many :catalogue_variants, dependent: :destroy

   def self.ransackable_associations(auth_object = nil)
    ["catalogue_variants"]
  end
   def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "size", "updated_at"]
  end
end  