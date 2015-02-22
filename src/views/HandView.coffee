class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.hide().html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$el.fadeIn(500)
    @$('.score').text @collection.finalScores()

  # rerender: (newCard) ->
  #   @$el.append new CardView(model: newCard).$el
  #   @$('.score').text @collection.finalScores()
