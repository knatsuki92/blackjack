assert = chai.assert
expect = chai.expect

describe 'App', ->
  app = null
  deck = null
  hand = null

  beforeEach ->
    app = new App()
    appView = new AppView(model: app)


    # deck = app.get('deck')
    # playerHand = app.get('playerHand')
    # dealerHand = app.get('dealerHand')
    # deck.reset([{rank: 5, suit: 3}, {rank: 5, suit: 1}, {rank: 3, suit: 1}, {rank: 10, suit: 1},{rank: 9, suit: 3}, {rank: 8, suit: 1}])
    # playerHand.reset()
    # dealerHand.reset()
    # deck.dealPlayer()
    # deck.dealDealer()

  xdescribe 'new round', ->
    it 'appView should render when app.newRound() is called', ->
      sinon.spy(appView,'render')
      app.newRound()
      expect(appView.render.called).to.be.true

