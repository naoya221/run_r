Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :messages, only: [:create]
  end
  resources :users, only: :show do
    resources :five_km_records,  only: [:create, :update]
    resources :ten_km_records,  only: [:create, :update]
    resources :half_records,  only: [:create, :update]
    resources :full_records,  only: [:create, :update]
  end
  resources :records,  only: [:new, :edit] 
  resources :vdots,  only: [:index] 
end
