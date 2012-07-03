class SearchesController < ApplicationController

  def create
    @tracks = Search.search_for_tracks(params[:query])
  end

end