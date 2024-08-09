class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :catalogues, dependent: :destroy 
end

