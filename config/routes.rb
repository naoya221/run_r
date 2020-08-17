Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets
  resources :users, only: :show
  resources :messages, only: [:new, :create]
end
