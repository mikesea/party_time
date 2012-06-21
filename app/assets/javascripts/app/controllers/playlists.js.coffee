class Playlist extends Spine.Controller
  elements:
    ".playlist-items" : "songs"

  constructor: ->
    super
    @songs.append @template()

  template: ->
    @view('playlists/song')

window.Playlist = Playlist