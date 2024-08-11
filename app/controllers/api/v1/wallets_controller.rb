class Api::V1::WalletsController < ApplicationController
	before_action :authenticate_account!

  def show
    @wallet = current_account.wallet
  end

  def add_funds
    @wallet = current_account.wallet
    amount = params[:amount].to_f

    if @wallet.credit(amount)
      Transaction.create(wallet: @wallet, amount: amount, transaction_type: 'credit', status: 'completed')
      render json: { success: true, balance: @wallet.balance }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def spend_funds
    @wallet = current_account.wallet
    amount = params[:amount].to_f
    catalogue_variant = CatalogueVariant.find(params[:catalogue_variant_id])

    transaction = Transaction.new(wallet: @wallet, amount: amount, transaction_type: 'debit', catalogue_variant: catalogue_variant)

    if transaction.save
      render json: { success: true, balance: @wallet.balance }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end
end
