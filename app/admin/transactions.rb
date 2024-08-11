ActiveAdmin.register Transaction do
  permit_params :wallet_id, :catalogue_variant_id, :amount, :transaction_type, :status

  # Eager-load associations to prevent N+1 queries
  controller do
    def scoped_collection
      super.includes(:wallet, :catalogue_variant)
    end
  end

  form do |f|
    f.inputs 'Transaction Details' do
      f.input :wallet
      f.input :catalogue_variant
      f.input :amount
      f.input :transaction_type
      f.input :status
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :wallet
    column :catalogue_variant
    column :amount
    column :transaction_type
    column :status
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :wallet
      row :catalogue_variant
      row :amount
      row :transaction_type
      row :status
      row :created_at
      row :updated_at
    end
  end

  filter :wallet
  filter :catalogue_variant
  filter :amount
  filter :transaction_type
  filter :status
  filter :created_at
  filter :updated_at
end
