require 'httparty'

module Api
  class Giphy
    def self.fetch(query:)
      response = HTTParty.get("http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=#{ENV['GIPHY_API_KEY']}&limit=15&offset=2")
      return response['data'].map do |gif|
        {
          'slug': gif['slug'],
          'original_url': gif.dig('images', 'original', 'url')
        }
      end
    end
  end
end