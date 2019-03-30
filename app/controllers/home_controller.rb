require_relative '../../lib/api/weather'
require_relative '../../lib/api/giphy'
require_relative '../../lib/api/movie'
require_relative '../../lib/api/movie_list'
require_relative '../../lib/api/quote'
require_relative '../../lib/api/news'
require_relative '../../lib/api/intent_recognizer'

class HomeController < ApplicationController

  def index
    # Guard Clause
    if params[:query].nil?
      render 'index' and return
    end
    
    history = History.new
    history.query = params[:query].downcase
    history.save!

    # query_array = params[:query].downcase.split(" ")
    # action = query_array.shift #eg: giphy or movie
    # query_req = query_array.join(' ') #eg: avengers or rainbow cats  
    action, query_req = Api::IntentRecognizer.new.recognize(query: params[:query])
     
    if action == "weather"
      @weather = Api::Weather.fetch(query: query_req)
    elsif action == "giphy"
      @giphies = Api::Giphy.fetch(query: query_req)
    elsif action == "movie"
      @movie = Api::MovieList.fetch(query: query_req)
    elsif action == "quote"
      @quote = Api::Quote.fetch(query: query_req)
      r = rand(255).to_s(16)
      g = rand(255).to_s(16)
      b = rand(255).to_s(16)
      r, g, b = [r, g, b].map { |s| if s.size == 1 then '0' + s else s end }
      @color = r + g + b 
    elsif action == "news"
      @news = Api::News.fetch(query: query_req)
    end

    render "#{action}/show"
  end

end
