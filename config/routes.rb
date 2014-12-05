Rails.application.routes.draw do

  get '/api/character' => 'home#character'
  get '/api/character/name' => 'home#character/:name'
  get '/api/characters' => 'home#characters'

  get '/search' => 'home#search'

  root 'home#index'

end
