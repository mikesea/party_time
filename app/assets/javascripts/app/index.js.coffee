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

class Recommender extends Spine.Controller
  @extend(Spine.Events)

  events:
    "click #recommend" : "recommendPlaylist"

  elements:
    ".track_preview_items" : "track_items"

  constructor: ->
    super

  recommendPlaylist: =>
    artists = $(".artist-items :input").serializeArray()
    $.ajax
      url: "/playlists"
      data: artists
      type: "post"
      success: (data) =>
        location.href = "/playlists/#{data.playlist.key}"
      error: (data) =>
        console.log data

    @loading()

  loading: =>
    $(".container").hide()
    $("#loading").show()

window.Recommender = Recommender
window.Party = Party