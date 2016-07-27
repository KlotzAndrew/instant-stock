require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :cash_holdings
      resources :trades
      resources :stocks
      resources :portfolios do
        resources :holdings
        resources :messages
      end

      get 'promo' => 'portfolios#promo'
    end
  end



  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'
end