class HomeController < ApplicationController
  include ComicVine

  def index
  end

  def search
    query = params['query']
    @characters = Character.all
    api_character = ComicVine.get_character(query)
      if @characters.include?(api_character)
        character = Character.find_by(name:query)
      elsif api_character
        character = Character.create({name: api_character.name...etc})
      else
        character = nil
      end
      character.to_json
  end
end


  #character is in database
  #character is not in database but in API
  #character is not in database and not in API
