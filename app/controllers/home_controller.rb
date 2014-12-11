class HomeController < ApplicationController

  def index
    @characters = Character.all
  end

  def search
    query = params['query'].downcase

    if Character.exists?(name: query)
      @character = Character.find_by(name: query)
      render 'home/results'
    elsif ComicVine.check_api(query) == "success"
      api_character = ComicVine.get_character(query)
      @character = Character.create(api_character)
      render 'home/results'
    else
      @character = "Sorry, no characters found! Search for another one."
      render 'home/index'
    end
  end

  def power
    @character.powers.split(', ').sample
  end

end
