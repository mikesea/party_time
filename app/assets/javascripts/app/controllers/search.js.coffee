class Search extends Spine.Controller
  @extend(Spine.Events)

  events:
    "submit #search_form" : "search"

  elements:
    "#query" : "query"
    ".search_items" : "results"

  constructor: ->
    super
    Track.bind 'create', @addResult

  search: (e) ->
    e.preventDefault()
    query = @query.val()
    return false unless query

    $.ajax
      url: "/search"
      data: 'query': query
      type: "post"
      success: (data) =>
        @results.empty()
        for obj in data
          Track.create
            artist_name: obj.track.artist_name,
            title: obj.track.title,
            album_title: obj.track.album_title,
            isSearch: true, 
            { ajax: false }
      error: (data) =>
        console.log data

  addResult: (track) =>
    if track.isSearch
      @results.append @template(track)

  template: (track) =>
    @view('playlists/track')(track)
    

window.Search = Search