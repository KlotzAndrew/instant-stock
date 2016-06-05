Rails.application.routes.draw do
  root to: 'portfolio#show'

  get 'portfolio/show'

  mount ActionCable.server => '/cable'
end
