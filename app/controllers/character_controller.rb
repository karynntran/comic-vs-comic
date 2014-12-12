class CharacterController < ApplicationController

  def index
    render json: Character.all
  end

end