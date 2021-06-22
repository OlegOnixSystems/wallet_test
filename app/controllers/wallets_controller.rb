class WalletsController < ApplicationController
  def show
    @wallet = Wallet.find(params[:id])
  end

  def create
    Wallet.create!(params.permit(:type, :name))
  rescue ActiveRecord::RecordInvalid => e
    flash[:errors] = e.to_s
  ensure
    redirect_to wallets_path
  end
end
