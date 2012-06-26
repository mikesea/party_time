class TracksController < ApplicationController
  def show
    @tracks = Playlist.find(params[:playlist_id]).tracks
  end
end
