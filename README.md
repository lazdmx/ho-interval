[![Build Status](https://travis-ci.org/lazutkin/ho-interval.png)](https://travis-ci.org/lazutkin/ho-interval)

ho-interval
===========

This library provides an simple representation of a half-open [x,y) interval defined on set of numbers. That is if you have a set of _something_ that may be compared (operations `==` and `<` are defined) than you may group them into intervals.

```
..,-20,-19.....a...........,0,..........b........ . . .  .  . . . ...........,1000,...

               ^                        ^
               |                        |
               +------------------------+
                     [a, b) interval   
```

__Note__: The `a-b` interval and all other intervals represented by library a `left-closed` class of a `half-open` intervals (see [here](http://en.wikipedia.org/wiki/Interval_(mathematics)) for details).

----
