# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

reactions = [
  "*char* goes flying across the city streets!",
  "*char* looks extremely uncomfortable.",
  "*char* laughs with derision.",
  "*char* groans, in pain.",
  "*char* blocks the move!",
  "*char* shields just in time.",
  "*char* says 'Is that all you got?'",
  "*char* gets thrown across the street, narrowly hitting the innocent civilians!",
  "*char* shakes his/her fist in anger.",
  "*char* shakes his/her head.",
  "*char* feels trapped."
]

reactions.each do |reaction|
  Reaction.create(reaction: reaction)
end

friends = [
"*friends* are here and they’re ready to fight.",
"You keep calling for help, but *friends* don’t arrive. Looks like you’re on your own for this one :( "
]

friends.each do |friend|
  Friend.create(friend: friend)
end

outcomes = [
  "*char2* grimaces, retreats and says 'You may have won this battle but I’ll be back!'",
  "This isn’t looking good! *char1* better run…looks like *char2* wins this round…poor civilians!",
  "Nothing good’s gonna come out of this one. *char1* and *char2* draw. Until the next battle…",
  "*char1* can’t go on and admits defeat. *char2* does a victory dance and blows up more buildings.",
]

outcomes.each do |outcome|
  Outcome.create(outcome: outcome)
end