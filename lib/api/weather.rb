require 'httparty'
require_relative 'geocoder'
module Api
  class Weather
    def fetch(query:)
      geometry = Api::Geocoder.new.fetch(query: query)
      response = HTTParty.get("https://api.darksky.net/forecast/08b00281f472f76d5b144da2d53fa28c/#{geometry["lat"]},#{geometry["lng"]}?units=si")
      {
        current_temperature: response["currently"]["temperature"],
        time_zone: response["timezone"],
        summary: response["currently"]["summary"],
        emoticon: weather_emoticon(response)
      } 
    end

    def weather_emoticon(response)
      icons = {
        "clear-day" => '🌞',
        "clear-night" => '🌚',
        "rain" => '🌧',
        "snow" => '❄',
        "sleet" => '🌨',
        "wind" =>  '🌬',
        "fog" =>  '🌫',
        "cloudy" => '☁',
        "partly-cloudy-day" =>  '🌤',
        "partly-cloudy-night" => '⛅'
      }
      icon = response["currently"]["icon"]
      icons[icon]
    end
  end
end