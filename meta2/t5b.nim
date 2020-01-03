import macros
import macros

macro echoName(msg: typed, x: untyped): typed =
  let node = nnkCommand.newTree(newIdentNode("echo"), msg)
  echo "rep= ", lispRepr(x,indented=true)
  insert(body(x), 0, node)
  echo "rep= ", lispRepr(x,indented=true)
  result = x

proc add(p : int) : int {.echoName: "calling add proc".} =
  result = p + 1

proc process(p:int) {.echoName: "calling process".} =
  echo "ans for ", p, " is ", add(p)

process(5)
process(8)


