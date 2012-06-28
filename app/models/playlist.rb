class Playlist
  include Ripple::Document
  one :event
  many :tracks 

  def self.build_from_artists(artists)
    playlist = Playlist.new
    playlist.tracks += Recommender.recommend_tracks_from_artists(artists)
    playlist
  end
end