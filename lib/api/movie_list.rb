require 'httparty'

module Api
  class MovieList
    def self.fetch(query:)
      response = HTTParty.get("http://www.omdbapi.com/?s=#{query}&apikey=2f6435d9")
      response["Search"].map do |search|
        {
          title: search['Title'],
          imdbID: search['imdbID']
        }
      end
    end
  end
end