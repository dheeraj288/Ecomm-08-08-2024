class CreateCatalogues < ActiveRecord::Migration[7.1]
  def change
    create_table :catalogues do |t|
      t.string :name
      t.string :description
      t.integer :category_id
      t.integer :sub_category_id
      t.integer :brand_id

      t.timestamps
    end
  end
end
