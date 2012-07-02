class Recommender

  def self.recommend_tracks_from_artists(artists=[], client=Nestling.new)
    response = client.playlist.static(
      artist: artists,
      bucket: "id:rdio-us-streaming",
      type: "artist-radio",
      limit: true
     )
    parse_echonest_response(response)
  end

  def self.parse_echonest_response(response)
    tracks = []
    response.each do |track|
      t = Track.new(
        artist_name: track[:artist_name],
        title: track[:title],
        rdio_id: track[:foreign_ids].first["foreign_id"].split(":").last
        )
      tracks << t
    end
    tracks
  end
end