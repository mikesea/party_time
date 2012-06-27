class PlaylistsController < ApplicationController
  def show
    unless @playlist = Playlist.find(params[:id])
      head status: :bad_request
    end
  end

  def create
    raise params[:artist].class.inspect
    # PLaylist.create_with_event(params[:event])
    #raise @event.inspect
    # if @playlist = Playlist.create_with_event(params[:event])
      # return json response with playlist key
    # else
    #   #return error
    # end
  end

  def new
  	@playlist = Playlist.new
  end
end
