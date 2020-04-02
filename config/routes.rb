# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[index show edit update]

  resources :tweets, only: %i[new create index show destroy] do
    resource :comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
  end

  get 'search', to: 'tweets#search'
  get 'favorites/index'
  root 'tweets#top'
end
