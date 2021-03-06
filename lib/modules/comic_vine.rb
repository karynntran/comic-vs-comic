module ComicVine

  def self.search_query(query)
    if Character.exists?(name: query)
      @character = Character.find_by(name: query)
    else
      result = check_api(query)
      if result == "success"
        api_character = get_character(query)
        @character = Character.create(api_character)
      else
        @character = nil
      end
    end
  end

  def self.get_character(query)
    query = query.gsub(" ","+")

    all_characters_url = "http://comicvine.com/api/characters/?api_key=#{api_key}&field_list=name,id,api_detail_url&filter=resource_type:character,name:#{query}"

    api_all_characters = HTTParty.get(all_characters_url)

    first_result_id = check_character_exists(api_all_characters)

    one_character_url = "http://comicvine.com/api/character/4005-#{first_result_id}?api_key=#{api_key}&field_list=name,teams,powers,id,image,team_friends,team_enemies,"
    api_single_character = HTTParty.get(one_character_url)

    name = api_single_character["response"]["results"]["name"]
    id = api_single_character["response"]["results"]["id"]
    image = api_single_character["response"]["results"]["image"]["medium_url"]

    hero_powers = api_single_character["response"]["results"]["powers"]
    powers = hero_powers.nil? ? 0 : hero_powers["power"].map { |p| p["name"] }.join(", ")

    begin
       team = api_single_character["response"]["results"]["teams"]["team"]
       team.map { |t| t["name"] }
    rescue
       team["name"]
    else
       teams = team.map { |t| t["name"] }
    end

    team_friends_team = api_single_character["response"]["results"]["team_friends"]
    team_friends = team_friends_team.nil? ? 0 :
                   team_friends_team["team"].map { |friends| friends["name"] }.join(", ")

    {name: name, image: image, powers: powers, friends: team_friends}
  end

  def self.check_character_exists(api_all_chars)
    check = api_all_chars["response"]["results"]["character"][0]
      if check == nil
        result = api_all_chars["response"]["results"]["character"]
      else
        result = api_all_chars["response"]["results"]["character"][0]
      end
      result["id"]
  end

  def self.check_api(query)
    query = query.gsub(" ","%20")

    all_characters_url = "http://comicvine.com/api/characters/?api_key=#{api_key}&field_list=name,id,api_detail_url&filter=resource_type:character,name:#{query}"

    api_all_characters = HTTParty.get(all_characters_url)

    api_all_characters = api_all_characters["response"]["results"]

    if api_all_characters == nil
      "failed"
    else
      "success"
    end
  end

  def self.api_key
    ENV['COMICVINE']
  end
end