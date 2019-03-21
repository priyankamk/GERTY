require_relative '../../lib/api/weather'
class WeatherController < ApplicationController
  def show
    @weather = Api::Weather.new.fetch(query: params[:query])
  end

 
end
