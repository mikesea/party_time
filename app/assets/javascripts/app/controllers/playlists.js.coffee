class Playlist extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".playlist-items" : "tracks"

  events:
    "click button#remove_track" : "removeTrack"

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
    @view('playlists/track')(track)

window.Playlist = Playlist