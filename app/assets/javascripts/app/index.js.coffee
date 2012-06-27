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
    "click #new_event_form"       : "newEvent"
    "click #tracks_primer_form"   : "primeTracks"
    "click #generate"             : "generatePlaylist"

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

  newEvent: (e) =>
    e.preventDefault()
    @navigate("/playlist/new/event")

  primeTracks: (e) =>
    e.preventDefault()
    @navigate("/playlist/new/music")

  generatePlaylist: =>

    date = $(".event_date :input").serialize()
    artists = $(".artist-items :input").serializeArray()
    info = $("input").serialize()
    
    $.ajax {
      url: "/playlists"
      data: artists
      type: "post"
    }

  Spine.Route.setup()

window.Generator = Generator
window.Party = Party