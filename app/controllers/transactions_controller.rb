class TransactionsController < ApplicationController
  def create
    wallet = Wallet.find(params[:wallet_id])
    Transaction.transfer(wallet, Wallet.find(params[:interact_wallet_id]), params[:amount])
  rescue ActiveRecord::RecordInvalid => e
    flash[:errors] = e.to_s
  ensure
    redirect_to wallet_path(wallet)
  end
end
