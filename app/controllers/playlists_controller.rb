class PlaylistsController < ApplicationController
  def show
    unless @playlist = Playlist.find(params[:id])
      head status: :bad_request
    end
  end

  def create
    playlist = Playlist.new
    playlist.recommend_tracks_from_artists(params[:artists])
    if playlist.save
      render :json => playlist, :status => :created
    else
      head status: :bad_request
    end
  end

  def new
  	@playlist = Playlist.new
  end
end
