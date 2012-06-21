class Search extends Spine.Controller
  @extend(Spine.Events)

  events:
    "submit #artist_search_form" : "search"

  elements:
    ".playlist-items" : "songs"

  constructor: ->
    super

  search: (e) ->
    e.preventDefault()
    alert "boom!"

window.Search = Search