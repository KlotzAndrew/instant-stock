require 'sidekiq/web'

Rails.application.routes.draw do
  resources :trades
  resources :stocks
  resources :holdings
  resources :portfolios
  root to: 'portfolio#show'

  get 'portfolio/show'

  post 'portfolio/message'

  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'
end
