class CreateCategoriesSubCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_sub_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :sub_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
