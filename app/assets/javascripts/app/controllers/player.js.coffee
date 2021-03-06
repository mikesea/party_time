#= require jquery.rdio

class Player extends Spine.Controller
  @extend(Spine.Events)

  events:
    "click .playlist-item"  : "playFromPlaylist"
    "click #previous"       : "previousTrack"

  elements:
    "#api"      : "api"
    "#play"     : "play"
    "#pause"    : "pause"
    "#previous" : "previous"
    "#next"     : "next"

  constructor: ->
    super
    Track.bind "refresh", @queueFirstTrack
    @loadPlayer()

  @play: (track_id) =>
    $("#api").rdio().clearQueue()
    $("#api").rdio().play(track_id)

  logIn: =>
    $(".alert").show()

  loadPlayer: =>
    @api.bind "ready.rdio", (e, userInfo) =>
      unless userInfo
        @logIn()
      Player.trigger "ready.player"

    @api.bind "playingTrackChanged.rdio", (e, playingTrack, sourcePosition) =>
      @queueNextTrack(playingTrack)
      $(".playing").removeClass("playing")
      $("##{playingTrack.key}").addClass("playing")
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

    @api.rdio @playbackToken()

    $("#play").click ->
      $("#api").rdio().play()

    $("#pause").click ->
      $("#api").rdio().pause()

    $("#next").click ->
      nextTrack = $(".playlist-item.playing").next()
      if nextTrack.length > 0
        $("#api").rdio().next()

  queueNextTrack: (currentTrack) =>
    nextTrack = $("##{currentTrack.key}").next()
    @api.rdio().queue nextTrack.attr("id")

  queueFirstTrack: =>
    Player.bind "ready.player", =>
      @api.rdio().queue(Track.first().id)

  nextTrack: =>
    currentTrack = $(".playlist-item.playing")
    nextTrack = $(".playlist-item.playing").next()
    if nextTrack.length > 0
      @playTrack(nextTrack.attr("data-rdio-id"))
      currentTrack.removeClass("playing")
      nextTrack.addClass("playing")
    else
      return false

  previousTrack: =>
    currentTrack = $(".playlist-item.playing")
    prevTrack = $(".playlist-item.playing").prev()
    if prevTrack.length > 0
      @api.rdio().clearQueue()
      @api.rdio().play(prevTrack.attr("data-rdio-id"))
      currentTrack.removeClass("playing")
      prevTrack.addClass("playing")
    else
      return false

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

  currentTrack: =>
    $(".current").attr("data-rdio-id")

  playbackToken: =>
    $("meta[name=playback_token]").attr('content')

window.Player = Player