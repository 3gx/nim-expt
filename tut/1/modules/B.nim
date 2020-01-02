# Module B
var x*: int
var z*: int = 33

proc x1*(a:int) : string = $a

when isMainModule:
  assert(x1(42) == "42")
#  assert(x1(42) == "43")  # will fail
