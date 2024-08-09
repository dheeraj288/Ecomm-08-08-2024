ActiveAdmin.register Category do
  permit_params :name, sub_categories_attributes: [:id, :name, :category_id, :_destroy]

  form do |f|
    f.inputs 'Category Details' do
      f.input :name, hint: "Enter the name of the category."
    end

    f.inputs 'SubCategories' do
      f.has_many :sub_categories, allow_destroy: true, new_record: true do |sub_f|
        sub_f.input :name, hint: "Enter the name of the subcategory."
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column "SubCategories Count" do |category|
      category.sub_categories.count
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end

    panel "SubCategories" do
      table_for category.sub_categories do
        column :name
        column "Catalogues Count" do |sub_category|
          sub_category.catalogues.count
        end
        column :created_at
      end
    end
  end

  filter :name
  filter :created_at
  filter :updated_at
end
