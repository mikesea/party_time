class Player extends Spine.Controller
  @extend(Spine.Events)

  events:
    "click .playlist-item" : "playFromPlaylist"
    "click #play" : "playFromPlayer"

  elements:
    "#api"      : "api"
    "#play"     : "play"
    "#pause"    : "pause"
    "#previous" : "previous"
    "#next"     : "next"

  constructor: ->
    super
    $("#pause").hide()
    @load()

  playFromPlayer: =>
    @api.rdio().play(@currentTrack())

  playFromPlaylist: (e) =>
    track = $(e.target).parent().attr("data-rdio-id")
    @api.rdio().play(track)

  currentTrack: =>
    $("#current-track").attr("data-rdio-id")

  load: =>
    @api.bind "ready.rdio"

    $("#api").bind "playingTrackChanged.rdio", (e, playingTrack, sourcePosition) =>
      if playingTrack
        duration = playingTrack.duration
        console.log playingTrack
        $("#art").attr "src", playingTrack.icon
        $("#track").text playingTrack.name
        $("#album").text playingTrack.album
        $("#artist").text playingTrack.artist

    $("#api").bind "positionChanged.rdio", (e, position) =>
      $("#position").css "width", Math.floor(100 * position / duration) + "%"

    $("#api").bind "playStateChanged.rdio", (e, playState) =>
      if playState is 0
        $("#play").show()
        $("#pause").hide()
      else
        $("#play").hide()
        $("#pause").show()

    $("#api").rdio "GAlNi78J_____zlyYWs5ZG02N2pkaHlhcWsyOWJtYjkyN2xvY2FsaG9zdEbwl7EHvbylWSWFWYMZwfc="
    $("#previous").click ->
      $("#api").rdio().previous()

    $("#pause").click =>
      $("#api").rdio().pause()

    $("#next").click =>
      $("#api").rdio().next(@nextTrack())

window.Player = Player