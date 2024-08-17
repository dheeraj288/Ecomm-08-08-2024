class AddAttrToBrand < ActiveRecord::Migration[7.1]
  def change
    add_column :brands, :date_of_birth, :datetime
  end
end
