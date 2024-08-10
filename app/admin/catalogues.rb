ActiveAdmin.register Catalogue do
  permit_params :name, :description, :category_id, :sub_category_id, :brand_id,
                catalogue_variants_attributes: [
                  :id, :catalogue_variant_color_id, :catalogue_variant_size_id, :_destroy,
                  catalogue_variant_color_attributes: [:id, :name, :color, :_destroy],
                  catalogue_variant_size_attributes: [:id, :name, :size, :_destroy]
                ]

  form do |f|
    f.inputs 'Catalogue Details' do
      f.input :name
      f.input :description
      f.input :category_id, as: :select, collection: Category.pluck(:name, :id)
      f.input :sub_category_id, as: :select, collection: SubCategory.pluck(:name, :id)
      f.input :brand_id, as: :select, collection: Brand.pluck(:name, :id)
    end


    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :category_id
    column :sub_category_id
    column :brand_id
    actions
  end

  filter :name
  filter :description
  filter :category_id
  filter :sub_category_id
  filter :brand_id
end
