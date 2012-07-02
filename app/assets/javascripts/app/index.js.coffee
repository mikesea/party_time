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
    @playlist = new Playlist({ el: @playlistEl })
    @player = new Player({ el: @playerEl })
    @search = new Search({ el: @searchEl })

class Recommender extends Spine.Controller
  @extend(Spine.Events)

  events:
    "click #recommend" : "recommendPlaylist"

  elements:
    ".modal"    : "modalEl"
    ".track_preview_items" : "track_items"

  constructor: ->
    super
    @dealer = new Dealer({ el: @modalEl })

  recommendPlaylist: =>
    artists = $(".artist-items :input").serializeArray()
    $.ajax
      url: "/playlists"
      data: artists
      type: "post"
      success: (data) =>
        $(".modal-footer").empty()
        $(".modal-footer").append "<a href='/playlists/#{data.playlist.key}' class='btn btn-success btn-large'>It's ready! Check out your playlist!</a>"
      error: (data) =>
        console.log data

    @loading()

  loading: =>
    $('#loading').modal()

window.Recommender = Recommender
window.Party = Party