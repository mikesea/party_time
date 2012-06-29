class SearchesController < ApplicationController

  def create
    search = Search.search_for_tracks(params[:query])
    render :json => search, :status => :ok
  end

end
