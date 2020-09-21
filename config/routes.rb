# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#top'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
end
