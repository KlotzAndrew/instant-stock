require 'sidekiq/web'

Rails.application.routes.draw do
  resources :cash_holdings
  resources :trades
  resources :stocks
  resources :portfolios do
    resources :holdings
  end

  root to: 'portfolios#index'

  get 'portfolio/show'

  post 'portfolio/message'

  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'
end
