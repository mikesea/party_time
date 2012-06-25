class PlaylistsController < ApplicationController
  def show
    @playlist = Playlist.find(params[:id])
    # render json: @playlist, status: :ok
  end
end
