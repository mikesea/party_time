class Player extends Spine.Controller
  elements:
    "#api" : "api"

  constructor: ->
    super
    $("#pause").hide()
    @load()

  load: ->
    @api.bind "ready.rdio"#, ->
      # $("#pause").hide()
      # $(this).rdio().play "a171827"

    $("#api").bind "playingTrackChanged.rdio", (e, playingTrack, sourcePosition) ->
      if playingTrack
        duration = playingTrack.duration
        console.log duration
        $("#art").attr "src", playingTrack.icon
        $("#track").text playingTrack.name
        $("#album").text playingTrack.album
        $("#artist").text playingTrack.artist

    $("#api").bind "positionChanged.rdio", (e, position) ->
      $("#position").css "width", Math.floor(100 * position / duration) + "%"

    $("#api").bind "playStateChanged.rdio", (e, playState) ->
      if playState is 0
        $("#play").show()
        $("#pause").hide()
      else
        $("#play").hide()
        $("#pause").show()

    $("#api").rdio "GAlNi78J_____zlyYWs5ZG02N2pkaHlhcWsyOWJtYjkyN2xvY2FsaG9zdEbwl7EHvbylWSWFWYMZwfc="
    $("#previous").click ->
      $("#api").rdio().previous()

    $("#play").click ->
      $("#api").rdio().play("t2838129")

    $("#pause").click ->
      $("#api").rdio().pause()

    $("#next").click ->
      $("#api").rdio().next()

window.Player = Player