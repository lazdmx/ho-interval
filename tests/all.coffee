HOInterval = require( "../index" )

chai   = require "chai"
expect = chai.expect
chai.should( )

describe "HOInterval#isValid", ->
  it "should be valid #1", -> expect( HOInterval.isValid 0 ).to.be.ok
  it "should be valid #2", -> expect( HOInterval.isValid 0, 0 ).to.be.ok
  it "should be valid #3", -> expect( HOInterval.isValid 0, 1 ).to.be.ok
  it "shouldn't be valid #1", -> expect( HOInterval.isValid 1, 0 ).to.not.be.ok

describe "#isIntersect", ->
  it "should find intersection #1", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 3, 8
    expect( aInt.isIntersect bInt ).to.be.ok
    expect( bInt.isIntersect aInt ).to.be.ok

  it "should find intersection #2", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 1, 5
    expect( aInt.isIntersect bInt ).to.be.ok

  it "should find intersection #3", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 3, 4
    expect( aInt.isIntersect bInt ).to.be.ok
    expect( bInt.isIntersect aInt ).to.be.ok

  it "should find intersection #4", ->
    aInt = new HOInterval 1
    bInt = new HOInterval 1
    expect( aInt.isIntersect bInt ).to.be.ok
    expect( bInt.isIntersect aInt ).to.be.ok

  it "shouldn't find intersection #1", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 7, 9
    expect( aInt.isIntersect bInt ).to.not.be.ok
    expect( bInt.isIntersect aInt ).to.not.be.ok

  it "shouldn't find intersection #2", ->
    aInt = new HOInterval 1
    bInt = new HOInterval 2
    expect( aInt.isIntersect bInt ).to.not.be.ok
    expect( bInt.isIntersect aInt ).to.not.be.ok

  it "shouldn't find intersection #3", ->
    aInt = new HOInterval 1, 2
    bInt = new HOInterval 3
    expect( aInt.isIntersect bInt ).to.not.be.ok
    expect( bInt.isIntersect aInt ).to.not.be.ok

describe "#isCloseTo", ->
  it "should be close to other #1", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 5, 9
    expect( aInt.isCloseTo bInt ).to.be.ok
    expect( bInt.isCloseTo aInt ).to.be.ok

  it "should be close to other #2", ->
    aInt = new HOInterval 1
    bInt = new HOInterval 1
    expect( aInt.isCloseTo bInt ).to.be.ok
    expect( bInt.isCloseTo aInt ).to.be.ok

  it "shouldn't be close to other if there is a gap", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 6, 9
    expect( aInt.isCloseTo bInt ).to.not.be.ok
    expect( bInt.isCloseTo aInt ).to.not.be.ok

  it "shouldn't be close to other if they have an intersection", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 3, 9
    expect( aInt.isCloseTo bInt ).to.not.be.ok
    expect( bInt.isCloseTo aInt ).to.not.be.ok

describe "#isEqualsTo", ->
  it "should be equal", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 1, 5
    expect( aInt.isEqualsTo bInt ).to.be.ok
    expect( bInt.isEqualsTo aInt ).to.be.ok

  it "shouldn't be equal", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 2, 5
    expect( aInt.isEqualsTo bInt ).to.not.be.ok
    expect( bInt.isEqualsTo aInt ).to.not.be.ok



describe "#intersect", ->
  it "should intersect two intervals", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 4, 9
    aInt.intersect bInt

    expect( aInt.a ).to.be.equals 4
    expect( aInt.b ).to.be.equals 5
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9

describe "#unite", ->
  it "should unite two intervals", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 4, 9
    aInt.unite bInt

    expect( aInt.a ).to.be.equals 1
    expect( aInt.b ).to.be.equals 9
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9


describe "HOInterval#intersect", ->
  it "should intersect two intervals", ->
    aInt = new HOInterval 1, 5
    bInt = new HOInterval 4, 9
    cInt = HOInterval.intersect aInt, bInt

    expect( aInt.a ).to.be.equals 1
    expect( aInt.b ).to.be.equals 5
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9
    expect( cInt.a ).to.be.equals 4
    expect( cInt.b ).to.be.equals 5


describe "HOInterval#unite", ->
  it "should unite #1", ->
    ints = [
      new HOInterval 1, 3
      new HOInterval 2, 4
      new HOInterval 3, 5
    ]

    ints = HOInterval.unite ints
    expect( ints ).to.have.length 1
    expect( ints[ 0 ].a ).to.be.equals 1
    expect( ints[ 0 ].b ).to.be.equals 5


  it "should unite #2", ->
    ints = [ ]
    ints = HOInterval.unite ints
    expect( ints ).to.have.length 0


  it "should unite #3", ->
    ints = [ new HOInterval 1, 3 ]

    ints = HOInterval.unite ints
    expect( ints ).to.have.length 1
    expect( ints[ 0 ].a ).to.be.equals 1
    expect( ints[ 0 ].b ).to.be.equals 3

  it "should unite #4", ->
    ints = [
      new HOInterval 1, 3
      new HOInterval 3, 5
    ]

    ints = HOInterval.unite ints
    expect( ints ).to.have.length 1
    expect( ints[ 0 ].a ).to.be.equals 1
    expect( ints[ 0 ].b ).to.be.equals 5

  it "should unite #5", ->
    ints = [
      new HOInterval 1, 3
      new HOInterval 4, 6
    ]

    ints = HOInterval.unite ints
    expect( ints ).to.have.length 2
    expect( ints[ 0 ].a ).to.be.equals 1
    expect( ints[ 0 ].b ).to.be.equals 3
    expect( ints[ 1 ].a ).to.be.equals 4
    expect( ints[ 1 ].b ).to.be.equals 6

  it "should unite #6", ->
    ints = [
      new HOInterval 1, 3
      new HOInterval 4, 6
      new HOInterval 0, 6
    ]

    ints = HOInterval.unite ints
    expect( ints ).to.have.length 1
    expect( ints[ 0 ].a ).to.be.equals 0
    expect( ints[ 0 ].b ).to.be.equals 6

describe "HOInterval#gaps", ->
  it "should convert to gaps #1", ->
    ints = [
      new HOInterval 1, 3
      new HOInterval 2, 4
      new HOInterval 3, 5
      new HOInterval 5
      new HOInterval 5
    ]

    ints = HOInterval.gaps ints
    expect( ints ).to.have.length 0

  it "should convert to gaps #2", ->
    ints = [
      new HOInterval 1, 3
      new HOInterval 5, 7
      new HOInterval 7
      new HOInterval 9
    ]

    ints = HOInterval.gaps ints
    expect( ints ).to.have.length 2
    expect( ints[ 0 ].a ).to.be.equals 3
    expect( ints[ 0 ].b ).to.be.equals 5
    expect( ints[ 1 ].a ).to.be.equals 7
    expect( ints[ 1 ].b ).to.be.equals 9
