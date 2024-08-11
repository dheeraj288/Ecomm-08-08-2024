ActiveAdmin.register Account do
  # Permitted parameters for assignment
  permit_params :first_name, :last_name, :full_phone_number, :country_code, 
                :phone_number, :email, :type, :password_digest

  # Index page configuration
  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :full_phone_number
    column :type
    actions
  end

  # Show page configuration
  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :full_phone_number
      row :country_code
      row :phone_number
      row :type
    end
  end

  # Form configuration
  form do |f|
    f.inputs 'Account Details' do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :country_code
      f.input :phone_number
      f.input :full_phone_number, input_html: { disabled: true }, hint: 'Automatically generated'
      f.input :type, as: :select, collection: Account.types.keys
      f.input :password_digest, as: :password
    end
    f.actions
  end
end