require 'httparty'

module Api
  class Geocoder
    def self.fetch(query:)
      response = HTTParty.get("https://api.opencagedata.com/geocode/v1/json?q=#{query}&key=#{ENV['GEOCODER_API_KEY']}")
      response["results"][0]["geometry"]
    end
  end
end