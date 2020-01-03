import macros

macro echoName(value: static[int], x: untyped): typed =
  let node = nnkCommand.newTree(newIdentNode("echo"), newLit($name(x) & $value))
  echo "rep= ", lispRepr(x,indented=true)
  insert(body(x), 0, node)
  echo "rep= ", lispRepr(x,indented=true)
  result = x

proc add(p : int) : int {.echoName: 42.} =
  result = p + 1

proc process(p:int) {.echoName: 43.} =
  echo "ans for ", p, " is ", add(p)

process(5)
process(8)

