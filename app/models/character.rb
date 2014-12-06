class Character < ActiveRecord::Base

  before_create do
    self.name = self.name.downcase
  end

  scope :has_power?, ->(power){ where("powers LIKE ?", "%#{power}%")}
  scope :has_friends?, ->(friend){ where("friends LIKE ?", "%#{friend}%")}
  scope :has_enemies?, ->(enemy){ where("enemies LIKE ?", "%#{enemy}%")}
  scope :has_team?, ->(team){ where("team LIKE ?", "%#{team}%")}

end
