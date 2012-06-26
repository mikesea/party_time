json.id @playlist.key
json.event @playlist.event, :date, :name, :details, :location
json.tracks @playlist.tracks, :artist_name, :title, :rdio_id