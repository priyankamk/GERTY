require 'httparty'

module Api
  class Giphy
    def fetch(query:)
      response = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=lFK5mZVF28MLD9SGsCPNwT3YoUvJ3THO&limit=12&offset=1")
      return response['data'].map do |gif|
        {
          'slug': gif['slug'],
          'original_url': gif.dig('images', 'original', 'url')
        }
      end
    end
  end
end