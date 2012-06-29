class Search extends Spine.Controller
  @extend(Spine.Events)

  events:
    "submit #search_form" : "search"

  elements:
    "#query" : "query"

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
        console.log data
      error: (data) =>
        console.log data
    

window.Search = Search