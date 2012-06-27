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
  elements:
    ".new_event"        : "eventEl"
    ".playlist_primer"  : "primerEl"

  constructor: ->
    super
    @event = new Event({ el: @eventEl })
    @primer = new PlaylistPrimer({ el: @primerEl })

  # Spine.Route.setup()

window.Generator = Generator
window.Party = Party