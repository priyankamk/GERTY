class HistoryController < ApplicationController
  def index
    @history = History.all.limit(30).order('created_at DESC')
  end

  def destroy
    d = History.find(params[:id])
    d.destroy

    redirect_to history_index_path
  end

  def clear 
    History.delete_all
    redirect_to history_index_path
  end
end
