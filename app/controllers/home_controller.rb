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
    story_data = {
      user_id: current_user.id,
      character_one: @character.name,
      }
    story = Story.create(story_data)
    render json: @character
  end

  def opponent
    story = current_user.stories.last
    random_opponent = Character.all.sample.name
    story.update_attributes(character_two: random_opponent)

    @opponent = Character.find_by(name: random_opponent)

    render json: @opponent
  end

  def power
    current_char = current_user.stories.last.character_one
    opponent = current_user.stories.last.character_two
    power = Character.find_by({name: current_char}).powers.split(", ").sample.upcase
    power_story = {story: "#{current_char.upcase} uses the power of #{power} against #{opponent.upcase}" }
    story = current_user.stories.last
    story.add_moves

    render json: power_story

  end

  def call_friends
    binding.pry
    current_char = current_user.stories.last.character_one
    team_friends = Character.find_by({name: current_char}).friends.split(", ").sample.upcase
    result = Friend.all.sample.friend
    @friend = result.gsub('*friends*', "#{team_friends}")

    story = current_user.stories.last
    story.add_moves

    render json: @friend

  end

  def help_out
  end

end


      # story_data = {
      #   user_id: current_user.id,
      #   character_one: @character,
      # }
      # story = Story.create(story_data)