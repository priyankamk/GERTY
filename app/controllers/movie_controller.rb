require_relative '../../lib/api/movie'

class MovieController < ApplicationController
  def detail
    @movie = Api::Movie.fetch(query: params[:imdbID])
    # raise @movie.inspect
  end
end
