# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    (@get 'playerHand').on 'bust', @dealerWins,@
    (@get 'playerHand').on 'stand' , (scores) ->
      (@get 'dealerHand').hitDealer()
    ,@

    (@get 'dealerHand').on 'bust', @playerWins,@
    (@get 'dealerHand').on 'stand', @compare,@

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
    newRound()

  newRound: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

