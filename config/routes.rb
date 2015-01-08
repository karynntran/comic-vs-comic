Rails.application.routes.draw do

  root 'home#index'

  post '/stories' => 'story#story'
  get '/stories/:id/opponent' => 'story#opponent'
  get '/power' => 'story#power'
  get '/call-friends' => 'story#call_friends'
  get '/help-out' => 'story#help_out'
  get '/reaction' => 'story#reaction'
  get '/opponent-power' => 'story#opponent_power'
  get '/reaction-to-opponent' => 'story#reaction_to_opponent'

  get '/characters' => 'character#index'

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
