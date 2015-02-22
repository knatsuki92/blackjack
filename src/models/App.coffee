# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @setEventHandlers()


  dealerWins: ->
    console.log 'dealer wins'

  playerWins: ->
    console.log 'player wins'

  compare: ->
    if (@get 'playerHand').finalScores() > (@get 'dealerHand').finalScores()
      @playerWins()
    else if (@get 'playerHand').finalScores() < (@get 'dealerHand').finalScores()
      @dealerWins()
    else
      @tie()

  tie: ->
    console.log 'tie!'

  setEventHandlers: ->
    (@get 'playerHand').on 'bust', @dealerWins,@
    (@get 'playerHand').on 'stand' , ->

      (@get 'dealerHand').hitDealer()
    ,@

    (@get 'dealerHand').on 'bust', @playerWins,@
    (@get 'dealerHand').on 'stand', @compare,@

  newRound: ->
    # @set 'deck', deck = new Deck()
    @set 'playerHand', (@get 'deck').dealPlayer()
    @set 'dealerHand', (@get 'deck').dealDealer()
    @setEventHandlers()
    @trigger 'newRound'
    return

