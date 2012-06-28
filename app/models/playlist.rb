class Playlist
  include Ripple::Document
  one :event
  many :tracks

  def recommend_tracks_from_artists(artists)
    self.tracks += Recommender.recommend_tracks_from_artists(artists)
  end
end