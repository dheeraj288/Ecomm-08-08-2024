class CatalogueVariantColor < ApplicationRecord
  has_many :catalogue_variants

  validates :name, :color, presence: true
end
