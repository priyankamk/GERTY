require_relative '../../lib/api/giphy'
class GiphyController < ApplicationController
  def index
    render layout: false
  end

  def show
    @giphies = Api::Giphy.new.fetch(query: params[:query])
  end
end
