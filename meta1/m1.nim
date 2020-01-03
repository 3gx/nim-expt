block:
  proc sayHi(name: string) =
    echo  "Hello ", name

  sayHi("World")
  sayHi "World"
  "World".sayHi

block:
  proc min[T](x,y: T): T =
    if x < y: x else: y

  echo min(2,3)
  echo min("foo", "bar")

block:
  iterator reverseItems(x: string): char =
    for i in countdown(x.high, x.low):
      yield x[i]

  for c in "foo".reverseItems:
    echo c

block:
  iterator reverseItems[T](x: T): auto =
    for i in countdown(x.high, x.low):
      yield x[i]

  for c in "foo".reverseItems:
    echo c

import math
block:
  proc powers(m: int): auto =
    return iterator: int =
      for n in 0..int.high:
        yield n^m

  var squares = powers(2)
  var cubes = powers(3)

  for i in 1..4:
    echo "Square: ", squares()

  for i in 1..4:
    echo "Cube: ", cubes()

  echo "Square: ", squares()
  echo "Cube: ", cubes()
