class Search extends Spine.Controller
  @extend(Spine.Events)

  events:
    "submit #search_form" : "search"
    "click #add_to_playlist" : "addToPlaylist"

  elements:
    "#query" : "query"
    ".search_items" : "results"

  constructor: ->
    super 
    SearchTrack.bind 'create', @addResult

  search: (e) ->
    e.preventDefault()
    query = @query.val()
    return false unless query

    $.ajax
      url: "/search"
      data: 'query': query
      type: "post"
      success: (tracks) =>
        @results.empty()
        for track in tracks
          SearchTrack.create
            id: track.id
            artist_name: track.artist_name,
            title: track.title,
            album_title: track.album_title,
            { ajax: false }
      error: (data) =>
        console.log data

  trackExists: (track) =>
    if Track.find(track.id)
      return true

  addToPlaylist: (e) ->
    id = $(e.target).parent().attr("data-rdio-id")
    track = SearchTrack.find(id)
    track.addToPlaylist()

  addResult: (track) =>
    @results.append @template(track)

  template: (track) =>
    @view('searches/search_track')(track)

window.Search = Search