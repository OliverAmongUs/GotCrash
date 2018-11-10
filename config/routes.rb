Rails.application.routes.draw do

  get '/profiles_edit', to: 'profiles#edit'
  get '/profiles', to: 'profiles#show'
  post '/profiles', to: 'profiles#show'

  get 'sessions/new'
  resources :users
  resources :owners, controller: :users, type: "Owner"
  resources :fixers, controller: :users, type: "Fixer"
  resources :fixers do
    resources :bids
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'choosereport', to: 'bids#choosereport'

  root 'home#welcome'
  get '/test/:id', to: 'users#show'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
end
