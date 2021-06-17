class TransactionsController < ApplicationController
  def new
    wallet = Wallet.find(params[:wallet_id])
    Transaction.transfer(wallet, Wallet.find(params[:interact_wallet_id]), params[:amount])
    redirect_to wallet_path(wallet)
  end
end
