class HomeController < ApplicationController

  def index
    @characters = Character.all
  end

  def search
    query = params['query'].downcase
    @character = ComicVine.search_query(query)

    story_data = {
      user_id: current_user.id,
      character_one: @character.name,
    }
    story = Story.create(story_data)
    render json: @character
  end



end

