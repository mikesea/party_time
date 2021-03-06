class Search

  def self.search_for_tracks(query)
    response = RDIO.search(
      query: query,
      types: "track",
      count: 5
      ).results
    parse_rdio_response(response)
  end

  def self.parse_rdio_response(response)
    tracks = []
    response.each do |track|
      if track.canStream
        t = Track.new(
          artist_name: track[:artist],
          album_title: track[:album],
          title: track[:name],
          album_art: track[:icon],
          rdio_id: track[:key])
        tracks << t
      end
    end
    tracks
  end

end