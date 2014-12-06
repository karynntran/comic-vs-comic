class HomeController < ApplicationController
  include ComicVine

  def index
    @characters = Character.all
  end

  def search
    query = params['query'].downcase
    if Character.exists?(name: query)
      @character = Character.find_by(name: query)
    else
      api_character = ComicVine.get_character(query)
      # hash = ComicVine.character_stats
      @character = Character.create(api_character)
    end
    @character
    render 'home/results'
    #Note: Need to handle errors
  end

end

