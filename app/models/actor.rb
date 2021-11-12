class Actor 
  attr_reader :actor
  def initialize(actor)
    @actor = actor
  end

  def parse
    @actor = @actor.split(/\_/).map(&:capitalize).join("_")
    query = "
    SELECT DISTINCT ?films
    WHERE {
    ?movie dbo:starring dbr:#{@actor} .
    ?movie foaf:name ?films .
      filter(langMatches(lang(?films),'en'))
    }"
    
    result = {"films" => []}
    client = SPARQL::Client.new("http://dbpedia.org/sparql")
    
    client.query(query).each do |film|
        film.each do |title| 
            result["films"] << title[1].to_s
        end
    end
    return results = result.to_json
  end
end
