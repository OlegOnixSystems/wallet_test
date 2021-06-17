class WalletsController < ApplicationController
  def show
    @wallet = Wallet.find(params[:id])
  end

  def create
    Wallet.create!(params.permit(:type, :name))
    redirect_to wallets_path
  end
end
