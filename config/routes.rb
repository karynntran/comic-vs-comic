Rails.application.routes.draw do

  root 'home#index'

  get '/search' => 'home#search'
  # get '/start-game' => 'home#start_game'
  get '/power' => 'home#power'

  resources :users, :only => [:show, :new, :create, :destroy]

  delete '/sessions' => 'sessions#destroy'

  get  '/login'  => "sessions#new",  as: 'login'
  post '/login'   => "sessions#create"

  get '/api/character' => 'api#character'
  get '/api/characters' => 'api#characters'
  get '/api/outcomes' => 'api#outcomes'
  get '/api/friend-outcomes' => 'api#friend_outcomes'
  get '/api/users' => 'api#users'

end
