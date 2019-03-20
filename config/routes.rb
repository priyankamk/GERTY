Rails.application.routes.draw do
  get '/', to: 'home#index'
  get 'about/index'

  post 'quote/show'
  post 'movie/show'
  post 'weather/show'
  post 'giphy/show'

  get 'history/index'
  # This 'history#destroy' should match the method name, you had `history#delete` which didn't exist
  delete 'history/:id', to: 'history#destroy'
  # resources :history
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
