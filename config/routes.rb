Rails.application.routes.draw do
  devise_for :users
  root 'tweets#index'
  resources :tweets do
    resources :messages, only: [:create]
  end
  resources :users, only: [:show, :edit, :update] do
    resources :vdots,  only: [:index]
    resources :five_km_records,  only: [:create, :update, :destroy]
    resources :ten_km_records,  only: [:create, :update, :destroy]
    resources :half_records,  only: [:create, :update, :destroy]
    resources :full_records,  only: [:create, :update, :destroy]
  end
  resources :records,  only: [:new, :edit] 
  resources :vdots,  only: [:index] 
end
