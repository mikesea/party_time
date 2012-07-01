class Track extends Spine.Model
  @configure 'Track', 'artist_name', 'title', 'rdio_id', 'album_title'
  @extend Spine.Model.Ajax

  @url: -> "/playlists/#{@playlist()}/tracks"

  @playlist: ->
    $("meta[name=playlist_id]").attr("content")

window.Track = Track