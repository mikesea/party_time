class Recommender

  # This value should be set in an initializer file to refer to the Nestling gem.
  # (e.g., Recommender.client = Nestling.new "APIKEY" )
  class << self
    attr_accessor :client
  end

  def self.recommend_tracks_from_artists(artists=[])
    response = client.playlist.static(
      artist: artists,
      bucket: "id:rdio-us-streaming",
      type: "artist-radio",
      limit: true)
    parse_echonest_response(response)
  end

  def self.parse_echonest_response(response)
    tracks = []
    response.each do |track|
      t = Track.new(
        artist_name: track[:artist_name],
        title: track[:title],
        rdio_id: track[:foreign_ids].first["foreign_id"].split(":").last)
      tracks << t
    end
    tracks
  end
end