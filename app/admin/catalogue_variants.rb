ActiveAdmin.register CatalogueVariant do
  # Permit parameters for CatalogueVariant
  permit_params :catalogue_id, :catalogue_variant_color_id, :catalogue_variant_size_id

  # Eager-load associations to prevent N+1 queries
  controller do
    def scoped_collection
      super.includes(:catalogue, :catalogue_variant_color, :catalogue_variant_size)
    end
  end

  form do |f|
    f.inputs 'Catalogue Variant Details' do
      f.input :catalogue
      f.input :catalogue_variant_color
      f.input :catalogue_variant_size
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :catalogue
    column :catalogue_variant_color
    column :catalogue_variant_size
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :catalogue
      row :catalogue_variant_color
      row :catalogue_variant_size
      row :created_at
      row :updated_at
    end
  end

  filter :catalogue
  filter :catalogue_variant_color
  filter :catalogue_variant_size
  filter :created_at
  filter :updated_at
end
