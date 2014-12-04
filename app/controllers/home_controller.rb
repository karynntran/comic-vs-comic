class HomeController < ApplicationController

  def index
  end

  def search
    query = params['query']
    ComicVine.get_characters
    respond_to do |format|
      @characters = Character.all
      if @characters.include?(query)
        format.json { render json: { status: "OK" } }
      else
        character = Character.create({name: query})
        @characters << character
        format.json { render json: { status: "OK" } }
      end
    end
  end

end
