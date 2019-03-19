require 'httparty'

module Api
  class Geocoder
    def fetch(query:)
      response = HTTParty.get("https://api.opencagedata.com/geocode/v1/json?q=#{query}&key=ab786933895a4bf0a0e9617d7f0c3386")
      response["results"][0]["geometry"]
    end
  end
end