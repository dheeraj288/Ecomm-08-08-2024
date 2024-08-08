class CreateCatalogueVariants < ActiveRecord::Migration[7.1]
  def change
    create_table :catalogue_variants do |t|
      t.integer :catalogue_id
      t.integer :catalogue_variant_color_id
      t.integer :catalogue_variant_size_id

      t.timestamps
    end
  end
end
