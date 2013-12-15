_ = require "underscore"

__unite = ( ints ) ->
  united = [ ]
  for x, idx1 in ints when not _.contains united, idx1
    for idx2 in [ idx1 + 1 ... ints.length ] when not _.contains united, idx2
      y = ints[ idx2 ]
      if x.isIntersect( y ) or x.isCloseTo( y )
        x.unite y
        united.push idx2
  united
    


class exports.HOInterval
  @clone: ( int ) -> new HOInterval int.a, int.b
  @length: ( int ) -> int.b - int.a
  @isValid: ( x, y ) -> x < y

  @unite: ( a, b ) -> HOInterval.clone( a ).unite( b )

  @uniteAll: ( ints ) ->
    while ( united = __unite ints ) and not _.isEmpty united
      ints.splice idx, 1 for idx in united.sort( ).reverse( )
    ints

  @intersect: ( a, b ) -> HOInterval.clone( a ).intersect( b )

  @toGaps: ( ints ) ->
    return [ ] if ints?.length < 2
    for n in [ 0 ... ints.length - 1 ]
      aInt = ints[ n ]
      bInt = ints[ n + 1 ]

      continue if aInt.isIntersect( bInt ) or aInt.isCloseTo( bInt )

      minB = _.min [ aInt.b, bInt.b ]
      maxA = _.max [ aInt.a, bInt.a ]
      new HOInterval( minB, maxA )

  constructor: ( @a, @b ) ->

  isCloseTo: ( other ) -> ( @b is other.a ) or ( @a is other.b )
  isEqualsTo: ( other ) -> ( @a is other.a ) and ( @b is other.b )

  isIntersect: ( x, y ) ->
    if x instanceof HOInterval
      y = x.b
      x = x.a
    return @a <= x < @b or x < @a < y

  unite: ( other ) ->
    return @ unless @isIntersect( other ) or @isCloseTo( other )
    minA = _.min [ @a, other.a ]
    maxB = _.max [ @b, other.b ]
    @a = minA
    @b = maxB
    @

  intersect: ( other ) ->
    throw @ unless @isIntersect( other )
    maxA = _.max [ @a, other.a ]
    minB = _.min [ @b, other.b ]
    @a = maxA
    @b = minB
    @


  add: ( val ) ->
    @a += val
    @b += val
    @

