Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update]
  resources :tweets, only: [:new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  
  root 'tweets#top'

end
