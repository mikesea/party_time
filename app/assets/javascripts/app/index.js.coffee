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

    # Spine.Route.setup()    

window.Party = Party