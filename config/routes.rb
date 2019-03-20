Rails.application.routes.draw do
  get '/', to: 'home#index'
  get 'about/index'

  post 'quote/show'
  post 'movie/show'
  post 'weather/show'
  post 'giphy/show'
  
  get 'history/index'
  delete 'history/:id', to: 'history#delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
