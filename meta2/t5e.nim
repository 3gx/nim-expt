import macros

type
  Parameters = tuple[value: int, ending: string]

macro echoName(p: static[Parameters], x: untyped): typed =
  echo "p= ", p
  echo "x= \n", lispRepr(x, indented=true)
  result = x

echoName (42,"p1"):
  proc add(p : int) : int =
    result = p + 1

  proc process(p:int) =
    echo "ans for ", p, " is ", add(p)

process(5)
process(8)

