type
  Vector* = object
    x, y, z: float

proc `[]=`* (v: var Vector, i: int, value: float) =
  # setter
  case i
  of 0: v.x = value
  of 1: v.y = value
  of 2: v.z = value
  else: assert(false)

proc `[]`* (v: Vector, i: int): float =
  # getter
  case i
  of 0: result = v.x
  of 1: result = v.y
  of 2: result = v.z
  else: assert(false)

var vec = Vector(x:3, y:4, z:5)
echo vec[0], " ", vec[1], " ", vec[2]
vec[1] = 42
echo vec[0], " ", vec[1], " ", vec[2]
