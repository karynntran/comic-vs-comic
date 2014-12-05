module ComicVine
  def self.get_character(query)
    #grab all characters that match the query
    all_characters_url = "http://comicvine.com/api/characters/?api_key=#{api_key}&field_list=name,id,api_detail_url&filter=name:#{query}"
    api_all_characters = HTTParty.get(all_characters_url)
    first_result_id = api_all_characters["response"]["results"]["character"][0]["id"]
    one_character_url = "http://comicvine.com/api/character/4005-#{first_result_id}?api_key=#{api_key}&field_list=name,powers,id,image,team_friends,team_enemies,teams"
    api_single_character = HTTParty.get(one_character_url)
    name = api_single_character["response"]["results"]["name"]
  end

  def self.character_stats
    #grab all characters that match the query
    get_character

    #grab single character
    # one_character_url = "http://comicvine.com/api/character/4005-#{first_result_id}?api_key=#{api_key}&field_list=name,powers,id,image,team_friends,team_enemies,teams"
    # api_single_character = HTTParty.get(one_character_url)

    #attributes
    name = api_single_character["response"]["results"]["name"]
    id = api_single_character["response"]["results"]["id"]
    image = api_single_character["response"]["results"]["image"]["medium_url"]

    powers_hash = api_single_character["response"]["results"]["powers"]["power"]
    powers = powers_hash.map { |power| power["name"] }

    team_friends_hash = api_single_character["response"]["results"]["team_friends"]["team"]
    team_friends = team_friends_hash.map { |friends| friends["name"] }

    team_enemies_hash = api_single_character["response"]["results"]["team_enemies"]["team"]
    team_enemies = team_enemies_hash.map { |enemies| enemies["name"] }

    character_hash = Hash[name: name, image: image, powers: powers, friends: team_friends, enemies: team_enemies]
  end

  def self.api_key
    ENV['ComicVine']
  end
end