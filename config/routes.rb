Rails.application.routes.draw do
  get '/', to: 'home#index'
  get 'about/index'

  post 'quote/show'
  post 'movie/show'
  post 'weather/show'
  post 'giphy/show'
  post 'history/clear'
  resources :history, only: [:index, :destroy]
end
