json.id @playlist.key
json.event_date @playlist.event_date
json.tracks @playlist.tracks, :artist_name, :title, :rdio_id