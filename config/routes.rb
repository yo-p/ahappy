Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update]
  
  resources :tweets, only: [:new, :create, :index, :show, :destroy] do
    resource :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  get 'search', to:'tweets#search'
  get 'favorites/index'
  root 'tweets#top'

end
