class HomeController < ApplicationController

  def index
    @characters = Character.all
  end

  def search
    query = params['query'].downcase

    if Character.exists?(name: query)
      @character = Character.find_by(name: query)
    else
      result = ComicVine.check_api(query)
      if result == "success"
        api_character = ComicVine.get_character(query)
        @character = Character.create(api_character)
      else
        flash.now[:error] = "#{query} is not found. Search again."
        redirect_to root_path
      end
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

    render json: {"value" => power_story}
  end

  def call_friends
    current_char = current_user.stories.last.character_one
    team_friends = Character.find_by({name: current_char}).friends.split(", ").sample.upcase
    result = Friend.all.sample.friend
    friend_story = {story: result.gsub('*friends*', "#{team_friends}")}

    story = current_user.stories.last
    story.add_moves

    render json: {"value" => friend_story}
  end

  def help_out
    power = current_user.powers.split(", ").sample.upcase
    opponent = current_user.stories.last.character_two

    user_story = {story: "#{current_user.username.upcase} joins the fray! #{current_user.username.upcase} uses the power of #{power} against #{opponent.upcase}"}

    story = current_user.stories.last
    story.add_moves

    render json: {"value" => user_story}
  end

  def reaction
    # current_char = current_user.stories.last.character_one
    opponent = current_user.stories.last.character_two
    reaction_story = {story: Reaction.all.sample.reaction.gsub('*char*',"#{opponent.upcase}")}

    render json: {"value" => reaction_story}
  end

  ### opponent actions ###
  def opponent_power
    current_char = current_user.stories.last.character_one
    opponent = current_user.stories.last.character_two
    power = Character.find_by({name: opponent}).powers.split(", ").sample.upcase
    opponent_power_story = {story: "#{opponent.upcase} uses the power of #{power} against #{current_char.upcase}" }

    render json: {"value" => opponent_power_story}
  end

  def reaction_to_opponent
    current_char = current_user.stories.last.character_one
    opponent_reaction_story = {story: Reaction.all.sample.reaction.gsub('*char*',"#{current_char.upcase}")}

    render json: {"value" => opponent_reaction_story}
  end

end

