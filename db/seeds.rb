# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Reaction.create(reaction: "*char* goes flying across the city streets!",hit_or_miss: "hit")
Reaction.create(reaction: "*char* groans, in pain.",hit_or_miss: "hit")
Reaction.create(reaction: "*char* gets thrown across the street, narrowly missing the innocent civilians!",hit_or_miss: "hit")
Reaction.create(reaction: "*char* shakes his/her fist in anger.",hit_or_miss: "hit")
Reaction.create(reaction: "*char* crashes onto the floor.",hit_or_miss: "hit" )
Reaction.create(reaction: "*char* feels trapped.",hit_or_miss: "hit")
Reaction.create(reaction: "*char* dodges but looks extremely uncomfortable.",hit_or_miss: "miss")
Reaction.create(reaction: "*char* laughs with derision.",hit_or_miss: "miss")
Reaction.create(reaction: "*char* blocks the move!",hit_or_miss: "miss")
Reaction.create(reaction: "*char* shields just in time.",hit_or_miss: "miss")
Reaction.create(reaction: "*char* scoffs 'Is that all you got?'",hit_or_miss: "miss")
Reaction.create(reaction: "*char* shakes his/her head.",hit_or_miss: "miss")


# reactions.each do |reaction,hit_or_miss|
#   Reaction.create(reaction: reaction, hit_or_miss: hit_or_miss)
# end

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