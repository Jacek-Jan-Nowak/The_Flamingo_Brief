class Film 
  attr_reader :film
  def initialize(film)
    @film = film
  end

  def parse
    movie = @film.split(/\_/).map(&:capitalize).join("_")
    query = "
    SELECT DISTINCT ?actorName
    WHERE {
     dbr:#{movie} dbo:starring ?actor .
      ?actor rdfs:label ?actorName .
      filter(langMatches(lang(?actorName),'en'))
    }"
    
    result = {"actors" => []}
    client = SPARQL::Client.new("http://dbpedia.org/sparql")
    
    client.query(query).each do |starring|
        starring.each do |actor| 
            result["actors"] << actor[1].to_s
        end
    end
    return results = result.to_json
  end
end
