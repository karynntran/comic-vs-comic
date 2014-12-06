Rails.application.routes.draw do

  get '/api/character' => 'api#character'
  get '/api/characters' => 'api#characters'

  get '/search' => 'home#search'

  root 'home#index'

end
