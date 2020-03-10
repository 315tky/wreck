Rails.application.routes.draw do
  get 'corporations/index'
  get 'corporations/show'
  root 'home#index'
  get 'home/index'

  get 'users/login'
  get 'users/logout'

  get '/users/:id', to: 'users#show', as: 'users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
