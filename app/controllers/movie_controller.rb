require_relative '../../lib/api/movie'

class MovieController < ApplicationController
  def show
    @movie = Api::Movie.new.fetch(query: params[:query])
    # raise @movie.inspect
  end
end
