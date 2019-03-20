class HistoryController < ApplicationController
  def index
    # Plural of History is history
    @history = History.all
  end

  # Spelling of destory is destroy
  def destroy
    d = History.find(params[:id])
    d.destroy

    redirect_to history_index_path
  end
end
