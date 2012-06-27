class Player extends Spine.Controller
  @extend(Spine.Events)

  events:
    "click .playlist-item"  : "playFromPlaylist"
    "click #play"           : "playFromPlayer"
    "click #pause"          : "pauseTrack"
    "click #next"           : "nextTrack"
    "click #previous"       : "previousTrack"

  elements:
    "#api"      : "api"
    "#play"     : "play"
    "#pause"    : "pause"
    "#previous" : "previous"
    "#next"     : "next"

  constructor: ->
    super
    @pause.hide()
    @load()

  nextTrack: =>
    currentTrack = $(".playlist-item.playing")
    nextTrack = $(".playlist-item.playing").next()
    if nextTrack.length > 0
      @playTrack(nextTrack.attr("data-rdio-id"))
      currentTrack.removeClass("playing")
      nextTrack.addClass("playing")
    else
      return

  previousTrack: =>
    currentTrack = $(".playlist-item.playing")
    prevTrack = $(".playlist-item.playing").prev()
    if prevTrack.length > 0
      @playTrack(prevTrack.attr("data-rdio-id"))
      currentTrack.removeClass("playing")
      prevTrack.addClass("playing")
    else
      return

  pauseTrack: =>
    track = $(".playlist-item.playing")
    track.removeClass("playing")
    track.addClass("paused")

  playFromPlayer: =>
    if $(".playlist-item.paused").length > 0
      track = $(".playlist-item.paused")
      track.removeClass("paused")
      @playTrack(track.attr("data-rdio-id"))
      track.addClass("playing")
    else
      track = $(".playlist-item:first")
      @playTrack(track.attr("data-rdio-id"))
      track.addClass("playing")

  playTrack: (rdio_id) =>
    @api.rdio().play(rdio_id)  

  currentTrack: =>
    $(".current").attr("data-rdio-id")

  load: =>
    @api.bind "ready.rdio"

    $("#api").bind "playingTrackChanged.rdio", (e, playingTrack, sourcePosition) =>
      @playingTrack = playingTrack
      if playingTrack
        duration = playingTrack.duration
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

    $("#pause").click =>
      $("#api").rdio().pause()

window.Player = Player