class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :catalogues, dependent: :destroy 
  
  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "id", "id_value", "name", "updated_at"]
  end
end

