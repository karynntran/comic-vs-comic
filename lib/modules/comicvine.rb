module ComicVine

  def self.get_characters
    character =
    query =
    url = "http://comicvine.com/api/search/?api_key=#{api_key}&resources=character&query=#{query}&field_list=name,origin,publisher")
    api_response = HTTParty.get(url)
    results = api["response"]["results"]["character"]
    all_characters = results.map { |result| result["name"] }
  end

  def self.character_stats

  end

  def self.api_key
    ENV['ComicVine']
  end

end