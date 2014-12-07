class ApiController < ApplicationController

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
    elsif params[:teams]
      character = Character.has_team?(params[:teams])
    else
      character = Character.all
    end
    render json: character
  end

  def characters
    characters = Character.all
    render json: characters
  end

  def outcomes
    outcomes = Outcome.all
    render json: outcomes
  end

  def friend_outcomes
    friends = Friend.all
    render json: friends
  end

  def users
    users = User.all
    render json: users
  end

end