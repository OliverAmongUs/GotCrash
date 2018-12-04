Rails.application.routes.draw do

  get 'report_join_auto/new'
  delete 'report_join_auto', to: 'report_join_auto#destroy'


  get 'reviews/new'
  get 'reviews/show'
  get 'reviews/index'
  post 'reviews/show'
  resources :reviews

  resources :messages

  get 'cars/edit'
  get 'cars/index'
  get 'cars/new'
  get 'cars/show'

  resources :cars

  # post '/cars/:id', to: 'car#show'
  # resources :cars
  # get '/car_edit', to: 'car#edit'

  get '/profiles_edit', to: 'profiles#edit'
  get '/profiles', to: 'profiles#show'
  post '/profiles', to: 'profiles#show'
  post 'profile/update', to: 'profile#update'

  get 'sessions/new'
  resources :users
  resources :owners, controller: :users, type: "Owner"
  resources :fixers, controller: :users, type: "Fixer"
  resources :reports


  post 'reports/:id',to: 'reports#completeReport'
  post 'search_report', to: 'reports#search_report'
  resources :fixers do
    resources :bids do
        resources :messages
      end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'choosereport', to: 'bids#choosereport'
  post 'filterreport', to: 'bids#filterreport'
  post 'showreport', to: 'bids#showreport'
  post 'search_bid', to: 'bids#search_bid'
  root 'home#index'
  get '/test/:id', to: 'users#show'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

end
