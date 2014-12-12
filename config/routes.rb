Rails.application.routes.draw do

  root 'home#index'

  get '/search' => 'home#search'
  get '/opponent' => 'home#opponent'
  get '/power' => 'home#power'
  get '/call-friends' => 'home#call_friends'
  get '/help-out' => 'home#help_out'
  get '/reaction' => 'home#reaction'


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
