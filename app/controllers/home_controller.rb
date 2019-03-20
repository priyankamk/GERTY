require_relative '../../lib/api/weather'
require_relative '../../lib/api/giphy'
require_relative '../../lib/api/movie'
require_relative '../../lib/api/quote'

class HomeController < ApplicationController

  def index
    # Guard Clause
    if params[:query].nil?
      render 'index' and return
    end
    
    history = History.new
    history.query = params[:query]
    history.save!

    query_array = params[:query].split(" ")
    action = query_array.shift #eg: giphy or movie
    query_req = query_array.join(' ') #eg: avengers or rainbow cats    
    if action == "weather"
      @weather = Api::Weather.new.fetch(query: query_req)
    elsif action == "giphy"
      @giphies = Api::Giphy.new.fetch(query: query_req)
    elsif action == "movie"
      @movie = Api::Movie.new.fetch(query: query_req)
    elsif action == "quote"
      @quote = Api::Quote.new.fetch(query: query_req)
      # @color = "%06x" % (rand * 0xffffff)  
      r = rand(255).to_s(16)
      g = rand(255).to_s(16)
      b = rand(255).to_s(16)
      r, g, b = [r, g, b].map { |s| if s.size == 1 then '0' + s else s end }
      @color = r + g + b 
    elsif action == "news"
      # raise @news.inspect
      @news = Api::News.new.fetch(query: query_req)
    end

    render "#{action}/show"
  end

end
