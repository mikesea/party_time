class Recommender

  class << self
    attr_accessor :client
  end

  # Instantiate a client to communicate with Echonest
  # Nestling is a wrapper gem for Echonest's API
  @client ||= Nestling.new

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