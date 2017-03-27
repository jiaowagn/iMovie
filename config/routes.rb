Rails.application.routes.draw do
  devise_for :users
  resources :lists do
    member do
      post :join
      post :quit
    end

    resources :reviews
  end

  namespace :account do
    resources :lists
  end 
  root 'lists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
