Rails.application.routes.draw do
  get 'puppies/index'
  get 'puppies/show'
  get 'puppies/new'
  get 'puppies/create'
  get 'puppies/edit'
  get 'puppies/update'
  get 'puppies/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :puppies
end
