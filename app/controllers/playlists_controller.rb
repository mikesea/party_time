class PlaylistsController < ApplicationController
  def show
    unless @playlist = Playlist.find(params[:id])
      head status: :bad_request
    end
  end
end
