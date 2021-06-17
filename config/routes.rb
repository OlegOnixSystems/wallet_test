Rails.application.routes.draw do
  get '/', to: redirect('/wallets')
  resources :wallets, only: %i[index show create] do
    resources :transactions, only: %i[create]
  end
end
