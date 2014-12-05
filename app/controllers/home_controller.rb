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
    elsif params[:powers]
      character = Character.has_power?(params[:powers])
    elsif params[:friends]
      character = Character.has_friends?(params[:friends])
    elsif params[:enemies]
      character = Character.has_enemies?(params[:enemies])
    elsif params[:image]
      character = Character.where({image: params[:image]})
    else
      character = Character.has_team?(params[:teams])
    end
    render json: character
  end

  def characters
    characters = Character.all
    render json: characters
  end

end

