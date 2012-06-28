json.array!(@tracks) do |json, track|
  json.artist_name track.artist_name
  json.title track.title
  json.rdio_id track.rdio_id
end