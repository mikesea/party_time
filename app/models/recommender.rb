require 'nestling'
require 'hashie'

class Recommender
  attr_reader :client

  def self.recommend_tracks_from_artists(artists=[], client=Nestling.new)
    playlist_rec = client.playlist.static(
      artist: artists,
      bucket: "id:rdio-us-streaming",
      type: "artist-radio",
      limit: true
     )
    parse_response(playlist_rec)
  end

  def self.parse_response(rec)
    tracks = []
    rec.each do |track|
      t = Track.new(
        artist_name: track.artist_name,
        title: track.title,
        rdio_id: track.foreign_ids.first["foreign_id"].split(":").last
        )
      tracks << t
    end
    tracks
  end
end