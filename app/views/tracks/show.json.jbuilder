@count = 0
json.array!(@tracks) do |json, track|
  @count += 1
  json.artist_name track.artist_name
  json.title track.title
  json.rdio_id track.rdio_id
  json.playlist_order @count
end