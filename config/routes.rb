Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
root "tasks#index"

  resources :tasks do
    collection do
      post:confirm
    end
  end

  namespace :admin do 
    resources :users 
  end  
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  
end
