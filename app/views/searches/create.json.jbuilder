json.array!(@tracks) do |json, track|
  json.id track.rdio_id
  json.artist_name track.artist_name
  json.album_title track.album_title
  json.album_art track.album_art
  json.title track.title
end