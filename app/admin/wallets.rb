ActiveAdmin.register Wallet do
  permit_params :account_id, :balance

  controller do
    def scoped_collection
      super.includes(:account)
    end
  end

  form do |f|
    f.inputs 'Wallet Details' do
      f.input :account_id, as: :select, collection: Account.pluck(:email, :id)
      f.input :balance
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :account_id
      row :balance
      row :created_at
      row :updated_at
    end

    panel "Account Information" do
      attributes_table_for wallet.account do
        row :email
      end
    end

    panel "Additional Information" do
      "Custom content or additional details can be placed here."
    end
  end
end
