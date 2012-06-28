class TracksController < ApplicationController
  before_filter :find_playlist, only: [ :destroy, :show ]
  
  def show
    @tracks = @playlist.tracks
  end

  def destroy
    @playlist.remove_track_by_rdio(params[:rdio_id])
  end
end
