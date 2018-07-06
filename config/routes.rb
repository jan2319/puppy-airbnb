Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => :users }
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :puppies do
    resources :bookings, only: [:new, :create, :show] do
      get 'confirm', to: "bookings#confirm"
    end
  end
  resources :bookings, only: [:index] do
    resources :reviews, only: [:new, :create, :show]
  end
end
