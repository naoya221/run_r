Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :messages, only: [:create]
  end
  resources :users, only: :show do
    resources :five_km_records,  only: [:create, :update]
  end
  resources :records,  only: [:new, :edit] 
end
