class Power < ActiveRecord::Base

  def first_char_move(query)
    character = Character.find_by(name: query)
    all_powers = character.powers.split(", ")
    power = all_powers.sample
    "#{character} uses the power of #{power}"
  end

  def second_char_move
  end

end
