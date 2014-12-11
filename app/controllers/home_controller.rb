class HomeController < ApplicationController

  def index
    @characters = Character.all
  end

  def search
    query = params['query'].downcase

    if Character.exists?(name: query)
      @character = Character.find_by(name: query)
    elsif ComicVine.check_api(query) == "success"
      api_character = ComicVine.get_character(query)
      @character = Character.create(api_character)
    else
      @character = "Sorry, no characters found! Search for another one."
    end
    render json: @character
  end

  def power
    @character.powers.split(', ').sample
  end

end


      # story_data = {
      #   user_id: current_user.id,
      #   character_one: @character,
      # }
      # story = Story.create(story_data)