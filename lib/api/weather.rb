require 'httparty'
require_relative 'geocoder'
module Api
  class Weather
    def fetch(query:)
      geometry = Api::Geocoder.new.fetch(query: query)
      response = HTTParty.get("https://api.darksky.net/forecast/08b00281f472f76d5b144da2d53fa28c/#{geometry["lat"]},#{geometry["lng"]}?units=si")
      
    end
  end
end