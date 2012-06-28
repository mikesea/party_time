class PlaylistsController < ApplicationController
  
  def new
    @playlist = Playlist.new
  end

  def show
    unless @playlist = Playlist.find(params[:id])
      head status: :bad_request
    end
  end

  def create
    playlist = Playlist.build_from_artists(params[:artists])
    if playlist.save
      render :json => playlist, :status => :created
    else
      head status: :bad_request
    end
  end

  def destroy
    if @playlist
      @playlist.remove_track
    else
      head status: :bad_request
    end
  end
end
