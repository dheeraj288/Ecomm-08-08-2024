ActiveAdmin.register Brand do
   permit_params :name, :date_of_birth

  index do
    selectable_column
    id_column
    column :name
    column :date_of_birth
    actions
  end

  filter :name
  

  form do |f|
    f.inputs do
      f.input :name
      f.input :date_of_birth
    end
    f.actions
  end
end
