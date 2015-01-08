class StoryController < ApplicationController

  def story
    query = params['query'].downcase
    @character = ComicVine.search_query(query)

    if @character == nil
      render json: @character
    else
      story_data = {
        user_id: current_user.id,
        character_one: @character.name,
      }
      story = Story.create(story_data)
      render json: @character
    end
  end

#REFACTOR NOTE: Pass story_id up with request
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
    render json: {"value" => power_story}
  end

  def call_friends
    current_char = current_user.stories.last.character_one
    team_friends = Character.find_by({name: current_char}).friends.split(", ").sample.upcase
    result = Friend.all.sample.friend
    friend_story = {story: result.gsub('*friends*', "#{team_friends}")}
    story = current_user.stories.last
    render json: {"value" => friend_story}
  end

  def help_out
    power = current_user.powers.split(", ").sample.upcase
    opponent = current_user.stories.last.character_two
    user_story = {story: "#{current_user.username.upcase} joins the fray! #{current_user.username.upcase} uses the power of #{power} against #{opponent.upcase}"}
    story = current_user.stories.last
    render json: {"value" => user_story}
  end

  def reaction
    story = current_user.stories.last
    opponent = current_user.stories.last.character_two
    opponent_image = Character.find_by(name: opponent).image
    rand_reaction = Reaction.all.sample
    reaction_type = rand_reaction.hit_or_miss
    if reaction_type == "hit"
      story.add_opponent_damage!
    end
    damage_status = story.char_two_damage
    outcome = story.winner?
    reaction_story = {story: rand_reaction.reaction.gsub('*char*',"#{opponent.upcase}"), type: reaction_type, damage: damage_status, outcome: outcome, image: opponent_image }
    render json: {"value" => reaction_story}
  end

##OPPONENT ACTIONS###
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
    current_char_image = Character.find_by(name: current_char).image
    rand_reaction = Reaction.all.sample
    reaction_type = rand_reaction.hit_or_miss
    if reaction_type == "hit"
      story.add_char_damage!
    end
    damage_status = story.char_one_damage
    outcome = story.winner?
    opponent_reaction_story = {story: rand_reaction.reaction.gsub('*char*',"#{current_char.upcase}"), type: reaction_type, damage: damage_status, outcome: outcome, image: current_char_image}

    render json: {"value" => opponent_reaction_story}
  end

end