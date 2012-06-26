class Playlist extends Spine.Controller
  elements:
    ".playlist-items" : "tracks"

  constructor: ->
    super
    Track.bind 'refresh', @addAll
    Track.fetch()

  addAll: =>
    for track in Track.all()
      @addOne(track)

  addOne: (track) =>
    @tracks.append @template(track)

  template: (track) ->
    @view('playlists/song')(track)

window.Playlist = Playlist