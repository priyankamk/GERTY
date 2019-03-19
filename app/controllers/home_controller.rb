require_relative '../../lib/api/weather'
require_relative '../../lib/api/giphy'
require_relative '../../lib/api/movie'

class HomeController < ApplicationController
  def index
    if params[:query].nil?
      render 'index' and return
    end

    query_array = params[:query].split(" ")
    action = query_array.shift #eg: giphy or movie
    query_req = query_array.join(' ') #eg: avengers or rainbow cats
    if action == "weather"
      @weather = Api::Weather.new.fetch(query: query_req)
    elsif action == "giphy"
      @giphies = Api::Giphy.new.fetch(query: query_req)
    elsif action == "movie"
      @movie = Api::Movie.new.fetch(query: query_req)
    end
    render "#{action}/show"
  end
end


# <ul>
# <li> <a href='/query=giphy+melhourne'> giphy melbourne </a></li>
# <li> weather melbourne </li>
# <li> giphy cats </li>
# </ul>