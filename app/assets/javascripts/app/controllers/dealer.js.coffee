class Dealer extends Spine.Controller
  
  elements:
    ".modal-body" : "body"

  constructor: ->
    super
    @renderDeal()

  renderDeal: =>
    $.ajax
      url: "/deal"
      type: "get"
      success: (data) =>
        @body.append @template(data)
      error: (data) =>
        @body.append @errorTemplate()

  template: (deal) ->
    @view('deals/deal')(deal)

  errorTemplate: ->
    @view('deals/error')

window.Dealer = Dealer