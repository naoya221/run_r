Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :messages, only: [:create]
  end
  resources :users, only: :show
end
