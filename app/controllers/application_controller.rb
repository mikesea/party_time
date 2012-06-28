class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :playlist

  private

  def find_playlist
    @playlist ||= Playlist.find(params[:playlist_id])
  end
end
