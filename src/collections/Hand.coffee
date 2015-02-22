class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    card = @deck.pop()
    @add(card)
    @checkBust()
    card

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: -> @trigger 'stand'

  bust: ->
    @trigger 'bust'

  checkBust: ->
    @bust() if (Math.min.apply null, @scores()) > 21

  hitDealer: ->
    @forEach (card)->
     if card.get('revealed') == false then card.flip()


    while (Math.max.apply null, @scores()) < 17
      @hit()

    @stand() if (Math.max.apply null, @scores()) <= 21
    @bust() if (Math.min.apply null, @scores()) >21

  finalScores: ->
    finalScore = (Math.max.apply null, @scores())
    if finalScore > 21 then finalScore = (Math.min.apply null, @scores())
    return finalScore
