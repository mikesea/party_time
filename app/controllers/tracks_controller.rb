class TracksController < ApplicationController
  def show
    # raise params.inspect
    @tracks = Playlist.find(params[:playlist_id]).tracks
    # render json: @tracks, status: :ok
  end
end
