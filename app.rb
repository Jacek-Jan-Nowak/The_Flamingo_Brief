require 'sinatra'
require 'sparql/client'
require_relative 'app/models/film'
require_relative 'app/models/actor'

    enable :sessions

get '/' do
    content_type :json
    actor_query = params["actor"]
    film_query = params["film"]
    if actor_query
        if session[actor_query] == NIL
            actor = Actor.new(actor_query)
            session[actor_query] = actor.parse
        end
        return session[actor_query]
    elsif film_query
        if session[film_query] == NIL
            film = Film.new(film_query)
            session[film_query] = film.parse
        end
        return session[film_query]
    else
        return("error, usage ?films= or ?actor=")
    end
end


