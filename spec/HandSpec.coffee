assert = chai.assert
expect = chai.expect

describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    card1 = new Card
      rank: 10
      suit: 1
    deck.reset([{rank: 10, suit: 3}, {rank: 5, suit: 1}, {rank: 3, suit: 1}, {rank: 10, suit: 1}])
    hand = deck.dealPlayer()

  describe 'hit', ->
    it 'should increase the number of cards by 1', ->
      prevLength = hand.length
      hand.hit()
      assert.strictEqual hand.length, prevLength + 1

  describe 'bust event', ->
    it 'should trigger the bust method when score exceeds 21', ->
      sinon.spy(hand, 'bust')
      hand.hit()
      hand.hit()
      expect(hand.bust.called).to.be.true
  describe 'hitDealer', ->
    it 'should trigger the "stand" event when score exceeds 17', ->
      sinon.spy(hand, 'stand')
      hand.hitDealer()
      expect(hand.stand.called).to.be.true
  describe 'finalScores', ->
    it 'should report the correct score', ->
      expect(hand.finalScores()).to.equal(13)

