#= require jquery.rdio

class Player extends Spine.Controller
  @extend(Spine.Events)

  events:
    # "click .playlist-item"  : "playFromPlaylist"
    # "click #play"           : "playFromPlayer"
    # "click #pause"          : "pauseTrack"
    # "click #next"           : "nextTrack"
    "click #previous"       : "previousTrack"

  elements:
    "#api"      : "api"
    "#play"     : "play"
    "#pause"    : "pause"
    "#previous" : "previous"
    "#next"     : "next"

  constructor: ->
    super
    Track.bind "refresh", @queueTracks
    @loadPlayer()

  loadPlayer: =>
    @api.bind "ready.rdio", (e, userInfo) =>
      console.log userInfo
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

    @api.rdio "GAlNi78J_____zlyYWs5ZG02N2pkaHlhcWsyOWJtYjkyN2xvY2FsaG9zdEbwl7EHvbylWSWFWYMZwfc="

    # $("#previous").click ->
    #   $("#api").rdio().previous()

    $("#play").click ->
      $("#api").rdio().play()

    $("#pause").click ->
      $("#api").rdio().pause()

    $("#next").click ->
      $("#api").rdio().next()

  queueNextTrack: (currentTrack) =>
    nextTrack = $("##{currentTrack.key}").next()
    @api.rdio().queue nextTrack.attr("id")

  queueTracks: =>
    Player.bind "ready.player", =>
      @api.rdio().queue(Track.first().id)
      # @api.rdio.play()
      # for t in Track.all()
      #   @api.rdio().queue(t.id)
      # @api.rdio().play(Track.first().id)
      # console.log Track.all()[1..-1]
      # @tracks = Track.all()
      # console.log @tracks.count
      # for t in Track.all()[1..-1]
      #   queueing "#{t.id}"
      #   @api.rdio().queue(track.id)

      # @api.rdio.play(Track.first().id)
      # console.log "going to play #{Track.first().id}"
      # @api.rdio().play(Track.first().id)
      # for track in Track.all()
      #   console.log "queueing #{track.id}"
      #   @api.rdio().queue(track.id)
      #   @api.rdio().play(track.id)
        # @api.rdio()
    
    # for track in Track.all()
      # @api.rdio().queue track.id

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

  playTrack: (rdio_id, position) =>
    # if position
    #   @api.rdio().play(rdio_id, { initialPosition: position })
    # else
    #   @api.rdio().play(rdio_id, { initialPosition: 10 })
    @api.rdio().play(rdio_id)

  currentTrack: =>
    $(".current").attr("data-rdio-id")

  newLoad: =>
    @api.bind "ready.rdio", (e, userInfo) ->
      # @api.rdio().play()
      console.log userInfo

    # @api.bind "queueChanged.rdio", (e, newQueue) =>
    #   console.log newQueue

    # @api.rdio "GAlNi78J_____zlyYWs5ZG02N2pkaHlhcWsyOWJtYjkyN2xvY2FsaG9zdEbwl7EHvbylWSWFWYMZwfc="

    #@api.rdio().play()

    # for track in Track.all()


  load: =>
    @api.bind "ready.rdio"

    $("#api").bind "playingTrackChanged.rdio", (e, playingTrack, sourcePosition) =>
      # console.log e
      @playingTrack = playingTrack
      if playingTrack
        duration = playingTrack.duration
        $("#art").attr "src", playingTrack.icon
        $("#track").text playingTrack.name
        $("#album").text playingTrack.album
        $("#artist").text playingTrack.artist

    $("#api").bind "positionChanged.rdio", (e, position) =>
      console.log position
      $("#position").css "width", Math.floor(100 * position / duration) + "%"

    $("#api").bind "playStateChanged.rdio", (e, playState) =>
      # console.log playState
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