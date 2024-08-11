class Api::V1::CheckoutsController < ApplicationController
	 before_action :authenticate_account!

  def create
    @wallet = current_account.wallet
    catalogue_variant = CatalogueVariant.find(params[:catalogue_variant_id])
    amount = catalogue_variant.price # Assuming `price` is an attribute of CatalogueVariant

    transaction = Transaction.new(wallet: @wallet, amount: amount, transaction_type: 'debit', catalogue_variant: catalogue_variant)

    if transaction.save && transaction.status == 'completed'
      # Logic to create order or handle successful payment
      render json: { success: true, message: 'Checkout successful' }, status: :ok
    else
      render json: { success: false, message: 'Insufficient balance or transaction failed' }, status: :unprocessable_entity
    end
  end
end
