Rails.application.routes.draw do

  get '/search' => 'home#search'

  root 'home#index'

end
