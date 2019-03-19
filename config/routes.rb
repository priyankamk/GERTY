Rails.application.routes.draw do
  post 'quote/show'
  post 'movie/show'
  post 'weather/show'
  get '/', to: 'home#index'
  post 'giphy/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
