require 'sidekiq/web'

Rails.application.routes.draw do
  resources :day_bars
  resources :minute_bars
  namespace :api do
    namespace :v1 do
      resources :cash_holdings
      resources :cash_trades
      resources :stock_trades
      resources :stocks
      resources :portfolios do
        resources :stock_holdings
        resources :messages
      end

      get 'promo' => 'portfolios#promo'
    end
  end



  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'
end
