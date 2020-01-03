import macros

macro echoName(x: untyped): untyped =
  let name = $name(x)
  let node = nnkCommand.newTree(
              newIdentNode("echo"), newLit(name))
  echo "rep= ", lispRepr(x,indented=true)
  insert(body(x), 0, node)
  echo "rep= ", lispRepr(x,indented=true)
  result = x

proc add(p : int) : int {.echoName.} =
  result = p + 1

proc process(p:int) {.echoName.} =
  echo "ans for ", p, " is ", add(p)

process(5)
process(8)


