assert = chai.assert

describe 'card', ->
  card = null

  beforeEach ->
    card = new Card
      rank: 10
      suit: 3

  describe 'flip', ->
    it 'should return false when flipped', ->
      card.flip()
      assert.strictEqual card.get('revealed'), false

