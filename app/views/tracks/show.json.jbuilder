json.array!(@tracks) do |json, track|
  json.id track.rdio_id
  json.artist_name track.artist_name
  json.title track.title
end