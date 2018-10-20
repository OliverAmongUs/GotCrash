Rails.application.routes.draw do
  resources :users
  resources :owners, controller: :users, type: "Owner"
  resources :fixers, controller: :users, type: "Fixer"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#welcome'
  get '/test/:id', to: 'users#show'
end
