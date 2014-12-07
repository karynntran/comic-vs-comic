Rails.application.routes.draw do

  resources :users, :only => [:show, :new, :create, :destroy]

  resources :sessions, :only => [:new, :create]

  delete '/sessions' => 'sessions#destroy'

  post '/login' => "sessions#new"

  get '/api/character' => 'api#character'
  get '/api/characters' => 'api#characters'
  get '/api/outcomes' => 'api#outcomes'
  get '/api/friend-outcomes' => 'api#friend_outcomes'
  get '/api/users' => 'api#users'

  get '/search' => 'home#search'

  root 'home#index'

end
