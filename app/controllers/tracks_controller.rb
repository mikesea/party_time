class TracksController < ApplicationController
  before_filter :find_playlist, only: [ :destroy, :show, :create ]
  
  def show
    @tracks = @playlist.tracks
  end

  def create
    if @playlist.add_track(@track = Track.new(params[:track]))
      @track
    else
      head status: :bad_request
    end
  end

  def destroy
    @playlist.remove_track_by_rdio(params[:rdio_id])
  end
end
