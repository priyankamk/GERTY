class HistoryController < ApplicationController
  def index
    @historys = History.all
  end
end
