class HistoryController < ApplicationController
  def index
    @historys = History.all
  end

  def destory
    d = History.find(params[:query])
    d.destory

    redirect_to "/history/index"
  end
end
