require 'httparty'
module Api
  class Movie
    def fetch(query:)
      # raise response.inspect
      # response = HTTParty.get("http://www.omdbapi.com/?s=#{query}&page=2&apikey=2f6435d9")
      # response['Search'].map do |movie|
      #   {
      #     'Title': movie['Title'],
      #     'Year': movie['Year']
      #   }
      # end
      
      response = HTTParty.get("http://www.omdbapi.com/?t=#{query}&apikey=2f6435d9")
      {
        title: response["Title"],
        year: response["Year"],
        plot: response["Plot"],
        genre: response["Genre"],
        poster: response["Poster"],
        rating: response["imdbRating"],
        director: response["Director"]
      }
    end
  end
end
