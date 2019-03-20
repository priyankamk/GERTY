class HistoryController < ApplicationController
  def index
    @history = History.all
  end
end
