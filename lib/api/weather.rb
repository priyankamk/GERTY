require 'httparty'
require_relative 'geocoder'

module Api
  class Weather
    def fetch(query:)
      geometry = Api::Geocoder.new.fetch(query: query)
      response = HTTParty.get("https://api.darksky.net/forecast/08b00281f472f76d5b144da2d53fa28c/#{geometry["lat"]},#{geometry["lng"]}?units=si")
        return {
          current_temperature: response["currently"]["temperature"],
          time_zone: response["timezone"],
          summary: response["currently"]["summary"],
          emoticon: weather_emoticon(response)
        }
    end

    def weather_emoticon(response)
      icons = {
        "clear-day" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/day.svg',
        "clear-night" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/night.svg',
        "rain" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/rainy-6.svg',
        "snow" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/snowy-6.svg',
        "sleet" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/snowy-5.svg',
        "wind" =>  'https://image.flaticon.com/icons/svg/959/959711.svg',
        "fog" =>  'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/cloudy.svg',
        "cloudy" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/cloudy.svg',
        "partly-cloudy-day" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/cloudy-day-1.svg',
        "partly-cloudy-night" => 'https://www.amcharts.com/wp-content/themes/amcharts4/css/img/icons/weather/animated/cloudy-night-3.svg'
      }
      icon = response["currently"]["icon"]
      icons[icon]
    end
  end
end