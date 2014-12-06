Rails.application.routes.draw do

  get '/api/character' => 'api#character'
  get '/api/characters' => 'api#characters'
  get '/api/outcomes' => 'api#outcomes'
  get '/api/friend-outcomes' => 'api#friend_outcomes'

  get '/search' => 'home#search'

  root 'home#index'

end
