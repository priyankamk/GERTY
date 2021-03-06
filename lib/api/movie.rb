require 'httparty'
# require_relative 'movie_list'
module Api
  class Movie
    def self.fetch(query:)
      # listOfMovie = Api::MovieList.new.fetch(query: query)
      response = HTTParty.get("http://www.omdbapi.com/?i=#{query}&apikey=#{ENV['MOVIE_API_KEY']}")
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