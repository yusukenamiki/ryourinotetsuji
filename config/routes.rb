Rails.application.routes.draw do
  devise_for :users
  post '/home/guest_sign_in', to: 'home#new_guest'
  root to: "home#index"
  resources :users
  resources :recipes
end
