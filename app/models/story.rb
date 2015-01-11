class Story < ActiveRecord::Base

  before_create :zero_moves

  def add_char_damage!
    self.char_one_damage += 1
    self.save!
  end

  def add_opponent_damage!
    self.char_two_damage += 1
    self.save!
  end

  def winner?
    if self.char_one_damage == 5
      Character.find_by(name: self.character_two)
    elsif self.char_two_damage == 5
      Character.find_by(name: self.character_one)
    else
      "none"
    end
  end

  def zero_moves
    self.char_one_damage = 0
    self.char_two_damage = 0
  end

end