class Brand < ApplicationRecord
  has_many :catalogues

  validates :name, presence: true
end
