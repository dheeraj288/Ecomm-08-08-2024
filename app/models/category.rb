class Category < ApplicationRecord
 has_many :sub_categories, dependent: :destroy
  accepts_nested_attributes_for :sub_categories, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
	def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
  
    def self.ransackable_associations(auth_object = nil)
    ["sub_categories"]
  end
end

