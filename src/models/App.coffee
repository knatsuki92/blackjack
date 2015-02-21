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
    @newRound()

  playerWins: ->
    console.log 'player wins'
    @newRound()

  compare: ->
    if (@get 'playerHand').scores() > (@get 'dealerHand').scores()
      @playerWins()
    else if (@get 'playerHand').scores() < (@get 'dealerHand').scores()
      @dealerWins()
    else
      @tie()

  tie: ->
    console.log 'tie!'
    @newRound()

  setEventHandlers: ->
    (@get 'playerHand').on 'bust', @dealerWins,@
    (@get 'playerHand').on 'stand' , ->
      (@get 'dealerHand').hitDealer()
    ,@

    (@get 'dealerHand').on 'bust', @playerWins,@
    (@get 'dealerHand').on 'stand', @compare,@

  newRound: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', (@get 'deck').dealPlayer()
    @set 'dealerHand', (@get 'deck').dealDealer()
    @setEventHandlers()
    @trigger 'newRound'
    return

