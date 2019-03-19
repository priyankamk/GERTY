class QuoteController < ApplicationController
  def show
    @quote = Api::Quote.new.fetch(query: params[:query])
  end
end
