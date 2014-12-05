class HomeController < ApplicationController
  include ComicVine

  def index
  end

  def search

    query = params['query']
    @characters = Character.all
    api_character = ComicVine.get_character(query)

    binding.pry

    hash = ComicVine.character_stats
      if @characters.include?(api_character)
        character = Character.find_by(name:query)
      elsif api_character
        character = Character.create(hash)
      else
        character = nil
      end
      character.to_json
  end
end


  #character is in database
  #character is not in database but in API
  #character is not in database and not in API
