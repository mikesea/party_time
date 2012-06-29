class Search extends Spine.Controller
  @extend(Spine.Events)

  events:
    "submit #search_form" : "search"

  elements:
    "#query" : "query"
    ".search_items" : "results"

  constructor: ->
    super
    console.log @el

  search: (e) ->
    e.preventDefault()
    query = @query.val()
    return false unless query

    $.ajax
      url: "/search"
      data: 'query': query
      type: "post"
      success: (data) =>
        for track in data
          @results.append "<li>Arist: #{track.track.artist_name}# // Album: #{track.track.album_title} - #{track.track.title}</li>"
      error: (data) =>
        console.log data
    

window.Search = Search