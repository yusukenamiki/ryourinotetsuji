Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: "home#index"
  resources :users
  resources :recipes do
    resource :favorites, only: [:create, :destroy]
  end
end
