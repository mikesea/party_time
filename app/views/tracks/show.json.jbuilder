@tracks.each do |track, count=0|
  json.artist_name track.artist_name
  json.title track.title
  json.rdio_id track.rdio_id
  json.playlist_order count += 1
end