class Search extends Spine.Controller
  @extend(Spine.Events)

  events:
    "submit #artist_search_form" : "search"

  elements:
    "#artist_search_form" : "artist_search"    

  constructor: ->
    super

  search: (e) ->
    e.preventDefault()
    console.log @artist_search

window.Search = Search