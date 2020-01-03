import macros

type
  Parameters = tuple[value: int, ending: string]

macro echoName(p: static[Parameters], x: untyped): typed =
  echo "rep= ", lispRepr(x,indented=true)
  let node = nnkCommand.newTree(newIdentNode("echo"),
                newLit($name(x) & $p.value & p.ending))
  insert(body(x), 0, node)
  echo "rep= ", lispRepr(x,indented=true)
  result = x

proc add(p : int) : int {.echoName: (42,"p1").} =
  result = p + 1

proc process(p:int) {.echoName: (43,"p2").} =
  echo "ans for ", p, " is ", add(p)

process(5)
process(8)

