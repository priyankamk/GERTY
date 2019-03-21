require 'httparty'
# require_relative 'movie_list'
module Api
  class Movie
    def fetch(query:)
      # listOfMovie = Api::MovieList.new.fetch(query: query)
      response = HTTParty.get("http://www.omdbapi.com/?i=#{query}&apikey=2f6435d9")
      return {
        title: response["Title"],
        year: response["Year"],
        plot: response["Plot"],
        genre: response["Genre"],
        poster: response["Poster"],
        rating: response["imdbRating"],
        director: response["Director"],
        released: response["Released"],
        actors: response["Actors"],
        runtime: response["Runtime"]
      }
    end
  end
end