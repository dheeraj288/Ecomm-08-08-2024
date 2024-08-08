class CatalogueVariantSize < ApplicationRecord
  has_many :catalogue_variants

  validates :name, :size, presence: true
end
