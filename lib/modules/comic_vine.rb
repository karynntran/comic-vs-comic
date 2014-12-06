module ComicVine
  def self.get_character(query)
    #grab all characters that match the query
    query = query.gsub(" ","%20")

    all_characters_url = "http://comicvine.com/api/characters/?api_key=#{api_key}&field_list=name,id,api_detail_url&filter=resource_type:character,name:#{query}"

    api_all_characters = HTTParty.get(all_characters_url)
    first_result_id = api_all_characters["response"]["results"]["character"]["id"]

    one_character_url = "http://comicvine.com/api/character/4005-#{first_result_id}?api_key=#{api_key}&field_list=name,teams,powers,id,image,team_friends,team_enemies,"
    api_single_character = HTTParty.get(one_character_url)
  # end

  # def self.character_stats
    #get stats of character
    # get_character(query)
    #attributes
    name = api_single_character["response"]["results"]["name"]
    id = api_single_character["response"]["results"]["id"]
    image = api_single_character["response"]["results"]["image"]["medium_url"]

    powers_hash = api_single_character["response"]["results"]["powers"]["power"]
    powers = powers_hash.map { |power| power["name"] }
    powers = powers.join(", ")

    team_hash = api_single_character["response"]["results"]["teams"]["team"]
    teams = team_hash.map { |team| team["name"] }
    teams = teams.join(", ")

    team_friends_hash = api_single_character["response"]["results"]["team_friends"]["team"]
    team_friends = team_friends_hash.map { |friends| friends["name"] }
    team_friends = team_friends.join(", ")

    team_enemies_hash = api_single_character["response"]["results"]["team_enemies"]["team"]
    team_enemies = team_enemies_hash.map { |enemies| enemies["name"] }
    team_enemies = team_enemies.join(", ")

    {name: name, image: image, powers: powers, friends: team_friends, enemies: team_enemies, team: teams}
  end

  # def self.character_hash
  #   {name: params[:name], image: params[:image], powers: params[:powers], friends: params[:team_friends], enemies: params[:team_enemies]}
  # end

  def self.api_key
    ENV['ComicVine']
  end
end