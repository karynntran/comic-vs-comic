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
    @character = @character
    render 'home/results'
    #Note: Need to handle errors
  end

  def character
    if params[:id]
      character = Character.where({id: params[:id]})
    elsif params[:name]
      character = Character.where({name: params[:name]})
    else
    end

    render json: character
  end

  def characters
    characters = Character.all
    render json: characters
  end

end

  # class API::HomeController < ApplicationController
  #   def character
  #   end
  # end

  #character is in database
  #character is not in database but in API
  #character is not in database and not in API

  # def search
  #   query = params['query']
  #   @characters = Character.all
  #   api_character = ComicVine.get_character(query)

  #   binding.pry

  #   hash = ComicVine.character_stats
  #     if @characters.include?(api_character)
  #       character = Character.find_by(name:query)
  #     elsif api_character
  #       character = Character.create(hash)
  #     else
  #       character = nil
  #     end
  #     character.to_json
  # end