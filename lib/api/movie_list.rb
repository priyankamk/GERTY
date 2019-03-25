require 'httparty'

module Api
  class MovieList
    def self.fetch(query:)
      response = HTTParty.get("http://www.omdbapi.com/?s=#{query}&apikey=#{ENV['MOVIE_API_KEY']}")
      response["Search"].map do |search|
        {
          title: search['Title'],
          imdbID: search['imdbID']
        }
      end
    end
  end
end