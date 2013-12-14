HOI = require( "../index" ).HOInterval

chai   = require "chai"
expect = chai.expect
chai.should( )

describe "HOInterval#isValid", ->
  it "should be valid", -> expect( HOI.isValid 0, 1 ).to.be.ok
  it "shouldn't be valid #1", -> expect( HOI.isValid 1, 0 ).to.not.be.ok
  it "shouldn't be valid #2", -> expect( HOI.isValid 0 ).to.not.be.ok

describe "#isIntersect", ->
  it "should find intersection #1", ->
    aInt = new HOI 1, 5
    bInt = new HOI 3, 8
    expect( aInt.isIntersect bInt ).to.be.ok
    expect( bInt.isIntersect aInt ).to.be.ok

  it "should find intersection #2", ->
    aInt = new HOI 1, 5
    bInt = new HOI 1, 5
    expect( aInt.isIntersect bInt ).to.be.ok

  it "should find intersection #3", ->
    aInt = new HOI 1, 5
    bInt = new HOI 3, 4
    expect( aInt.isIntersect bInt ).to.be.ok
    expect( bInt.isIntersect aInt ).to.be.ok

  it "shouldn't find intersection", ->
    aInt = new HOI 1, 5
    bInt = new HOI 7, 9
    expect( aInt.isIntersect bInt ).to.not.be.ok
    expect( bInt.isIntersect aInt ).to.not.be.ok

describe "#isCloseTo", ->
  it "should be close to other", ->
    aInt = new HOI 1, 5
    bInt = new HOI 5, 9
    expect( aInt.isCloseTo bInt ).to.be.ok
    expect( bInt.isCloseTo aInt ).to.be.ok

  it "shouldn't be close to other if there is a gap", ->
    aInt = new HOI 1, 5
    bInt = new HOI 6, 9
    expect( aInt.isCloseTo bInt ).to.not.be.ok
    expect( bInt.isCloseTo aInt ).to.not.be.ok

  it "shouldn't be close to other if they have an intersection", ->
    aInt = new HOI 1, 5
    bInt = new HOI 3, 9
    expect( aInt.isCloseTo bInt ).to.not.be.ok
    expect( bInt.isCloseTo aInt ).to.not.be.ok

describe "#isEqualsTo", ->
  it "should be equal", ->
    aInt = new HOI 1, 5
    bInt = new HOI 1, 5
    expect( aInt.isEqualsTo bInt ).to.be.ok
    expect( bInt.isEqualsTo aInt ).to.be.ok

  it "shouldn't be equal", ->
    aInt = new HOI 1, 5
    bInt = new HOI 2, 5
    expect( aInt.isEqualsTo bInt ).to.not.be.ok
    expect( bInt.isEqualsTo aInt ).to.not.be.ok



describe "#intersect", ->
  it "should intersect two intervals", ->
    aInt = new HOI 1, 5
    bInt = new HOI 4, 9
    aInt.intersect bInt

    expect( aInt.a ).to.be.equals 4
    expect( aInt.b ).to.be.equals 5
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9

describe "#unite", ->
  it "should unite two intervals", ->
    aInt = new HOI 1, 5
    bInt = new HOI 4, 9
    aInt.unite bInt

    expect( aInt.a ).to.be.equals 1
    expect( aInt.b ).to.be.equals 9
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9


describe "HOInterval#intersect", ->
  it "should intersect two intervals", ->
    aInt = new HOI 1, 5
    bInt = new HOI 4, 9
    cInt = HOI.intersect aInt, bInt

    expect( aInt.a ).to.be.equals 1
    expect( aInt.b ).to.be.equals 5
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9
    expect( cInt.a ).to.be.equals 4
    expect( cInt.b ).to.be.equals 5


describe "HOInterval#unite", ->
  it "should unite two intervals", ->
    aInt = new HOI 1, 5
    bInt = new HOI 4, 9
    cInt = HOI.unite aInt, bInt

    expect( aInt.a ).to.be.equals 1
    expect( aInt.b ).to.be.equals 5
    expect( bInt.a ).to.be.equals 4
    expect( bInt.b ).to.be.equals 9
    expect( cInt.a ).to.be.equals 1
    expect( cInt.b ).to.be.equals 9

