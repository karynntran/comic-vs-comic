class Story < ActiveRecord::Base

  before_create :zero_moves

  def begin_story

  end

  def self.call_powers
    #random power using current character
    #update story move table
    power = @character.powers.split(', ').sample
  end

  def self.call_friends
    #random friends team using current character
    #update story move table
    friend = @character.friends.split(', ').sample
    story = Friend.sample
    @friend_story = story.gsub('*friends','#{friend}')
  end

  def user_powers
    #random power that the user input
    #update story move table
  end

  def comp_reaction
    #random reaction by the computer
    #update story move table
  end

  def comp_story
    #random power, friends or enemies story generated by computer character
    #update story move table
  end

  def outcome
  end

##before create##

  def zero_moves
    self.moves = 0
  end


end