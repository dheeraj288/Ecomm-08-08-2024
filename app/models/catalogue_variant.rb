class CatalogueVariant < ApplicationRecord
  belongs_to :catalogue
  belongs_to :catalogue_variant_color
  belongs_to :catalogue_variant_size

  validates :catalogue_id, :catalogue_variant_color_id, :catalogue_variant_size_id, presence: true
end
