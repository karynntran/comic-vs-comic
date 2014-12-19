class HomeController < ApplicationController

  def index
    @characters = Character.all
  end








## MOVE TO STORIES CONTROLLER

  def search

    # Refector to be the create of [post: /stories]

    query = params['query'].downcase

# MOVE SEARCH TO MOD ComicVine.search(query)

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
      # MOVE TO STORY CONTROLLER ALL /stories/:id/opponent
    story = current_user.stories.last
    random_opponent = Character.all.sample.name
    story.update_attributes(character_two: random_opponent)

    @opponent = Character.find_by(name: random_opponent)

    render json: @opponent
  end

  def power
    # MOVE TO STORY CONTROLLER ALL /stories/:id/power

    # AJM:  Consider passing story id up with request...
    # story = Story.find(params[:id])
    # current_char = story.character_one
    # opponent = story.character_two

    current_char = current_user.stories.last.character_one
    opponent = current_user.stories.last.character_two
    power = Character.find_by({name: current_char}).powers.split(", ").sample.upcase
    power_story = {story: "#{current_char.upcase} uses the power of #{power} against #{opponent.upcase}" }
    story = current_user.stories.last
    render json: {"value" => power_story}

    # story.recieve_opponent_damage!

      # render json: {"value" => power_story, "opponent_damage" => story.opponent_damage, "current_char" => story.current_char_damage}

  end

  def call_friends

    # MOVE TO STORY CONTROLLER ALL /stories/:id/call_friends

    current_char = current_user.stories.last.character_one
    team_friends = Character.find_by({name: current_char}).friends.split(", ").sample.upcase
    result = Friend.all.sample.friend
    friend_story = {story: result.gsub('*friends*', "#{team_friends}")}

    story = current_user.stories.last
    # story.add_moves

    render json: {"value" => friend_story}
  end

  def help_out

    # MOVE TO STORY CONTROLLER ALL /stories/:id/help_out

    power = current_user.powers.split(", ").sample.upcase
    opponent = current_user.stories.last.character_two

    user_story = {story: "#{current_user.username.upcase} joins the fray! #{current_user.username.upcase} uses the power of #{power} against #{opponent.upcase}"}

    story = current_user.stories.last
    # story.add_moves

    render json: {"value" => user_story}
  end

  def reaction
    # MOVE TO STORY CONTROLLER ALL /stories/:id/reaction

    # current_char = current_user.stories.last.character_one
    story = current_user.stories.last

    opponent = current_user.stories.last.character_two
    rand_reaction = Reaction.all.sample
    reaction_type = rand_reaction.hit_or_miss

    if reaction_type == "hit"
      story.add_opponent_damage!
    end
    damage_status = story.char_two_damage

    outcome = story.winner?

    reaction_story = {story: rand_reaction.reaction.gsub('*char*',"#{opponent.upcase}"), type: reaction_type, damage: damage_status, outcome: outcome }

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
    story = current_user.stories.last

    current_char = current_user.stories.last.character_one
    rand_reaction = Reaction.all.sample
    reaction_type = rand_reaction.hit_or_miss

    if reaction_type == "hit"
      story.add_char_damage!
    end

    damage_status = story.char_one_damage

    outcome = story.winner?

    opponent_reaction_story = {story: rand_reaction.reaction.gsub('*char*',"#{current_char.upcase}"), type: reaction_type, damage: damage_status, outcome: outcome}

    render json: {"value" => opponent_reaction_story}
  end


  #  ^^^^^ MOVE TO STORY CONTROLER ^^^^^^

end

