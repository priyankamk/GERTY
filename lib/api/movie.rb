require 'httparty'
module Api
  class Movie
    def fetch(query:)
      movie_name = query.split(" ")[1]
      response = HTTParty.get("http://www.omdbapi.com/?t=#{movie_name}&apikey=2f6435d9")
      {
        title: response["Title"],
        year: response["Year"],
        plot: response["Plot"],
        genre: response["Genre"],
        poster: response["Poster"],
        rating: response["imdbRating"],
        director: response["Director"],
        released: response["Released"],
        actors: response["Actors"]
      }
    end
  end
end
