class Playlist
  include Ripple::Document
  one :event
  many :tracks 

  def self.build_from_artists(artists)
    playlist = Playlist.new
    tracks = Recommender.recommend_tracks_from_artists(artists)
    tracks.each { |track| playlist.tracks << track }
    playlist
  end

  def add_track(track)
    unless find_track_by_rdio(track.rdio_id)
      tracks << track
      save
    end
  end

  def remove_track(track)
    tracks.delete(track)
    save
  end

  def remove_track_by_rdio(rdio_id)
    track = find_track_by_rdio(rdio_id)
    unless track.nil?
      tracks.delete(track)
      save
    end
  end

  def find_track_by_rdio(rdio_id)
    tracks.find { |t| t.rdio_id == rdio_id }
  end
end