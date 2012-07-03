class Playlist extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".playlist-items" : "tracks"

  events:
    "click .playlist-item p" : "playTrack"

  constructor: ->
    super
    Track.bind 'refresh', @addAll
    Track.bind 'create', @addOne
    Track.fetch()

  playTrack: (e) =>
    track_id = $(e.target).parent().attr("id")
    Player.play(track_id) if track_id

  addAll: =>
    for track in Track.all()
      @addOne(track)

  addOne: (track) =>
    @tracks.append @template(track)

  template: (track) ->
    @view('playlists/track')(track)

window.Playlist = Playlist