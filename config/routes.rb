Rails.application.routes.draw do
  root 'tweets#index'
  resources :tweets
end
