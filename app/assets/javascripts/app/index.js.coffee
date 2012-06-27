#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class Party extends Spine.Controller
  elements:
    ".playlist" : "playlistEl"
    ".search"   : "searchEl"
    ".player"   : "playerEl"

  constructor: ->
    super
    @search = new Search({ el: @searchEl })
    @playlist = new Playlist({ el: @playlistEl })
    @player = new Player({ el: @playerEl }) 

class Generator extends Spine.Controller
  @extend(Spine.Events)

  elements:
    ".welcome"          : "welcome"
    "#get_started"      : "get_started"
    ".new_event"        : "eventEl"
    ".playlist_primer"  : "primerEl"

  events:
    "click #get_started"  : "createEvent"
    "click #pick_tracks"  : "pickTracks"

  constructor: ->
    super
    @routes
      "/": =>
        @welcome.show()
        @eventEl.hide()
        @primerEl.hide()
      "/playlist/new/event": =>
        @welcome.hide()
        @primerEl.hide()
        @eventEl.show()
      "/playlist/new/music": =>
        @welcome.hide()
        @eventEl.hide()
        @primerEl.show()

  createEvent: (e) =>
    e.preventDefault()
    @navigate("/playlist/new/event")

  pickTracks: (e) =>
    e.preventDefault()
    @navigate("/playlist/new/music")

  Spine.Route.setup()

window.Generator = Generator
window.Party = Party