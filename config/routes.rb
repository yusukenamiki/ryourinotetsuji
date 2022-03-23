Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root to: 'home#index'

  resources :users do
    resources :favorites

    resource :relationships, only: %i[create destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  resources :recipes do
    resource :favorites, only: %i[create destroy]

    resources :comments
  end
end
