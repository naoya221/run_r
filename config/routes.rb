Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  resources :tops, only: :index
  root 'tops#index'

  resources :tweets do
    collection do
      get 'search'
    end
    resources :messages, only: :create
  end

  resources :tags do
    get 'tweets', to: 'tweets#tag_search'
  end

  resources :users, only: :show do
    member do
      get :following, :followers
    end

    resources :five_km_records,  only: [:create, :update, :destroy]
    resources :ten_km_records,  only: [:create, :update, :destroy]
    resources :half_records,  only: [:create, :update, :destroy]
    resources :full_records,  only: [:create, :update, :destroy]
  end

  resources :follow_relationships, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
  resources :records,  only: [:new, :edit]
  resources :vdots,  only: [:index]
  post '/tweets/:tweet_id/likes' => 'likes#create'
  delete '/tweets/:tweet_id/likes' => 'likes#destroy'
  mount ActionCable.server => '/cable'

end
