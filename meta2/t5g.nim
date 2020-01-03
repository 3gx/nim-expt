import macros

macro echoName(msg: static[string], x: untyped): typed =
  for child in x.children():
    if child.kind == nnkProcDef:
      let node = nnkCommand.newTree(newIdentNode("echo"),
                    newLit($name(child) & "-" & $msg))
      insert(body(child), 0, node)
  result = x;

echoName("called"):
  echo "an echo statement"
  proc add(p : int) : int =
    result = p + 1
  echo "another an echo statement"
  proc process(p:int) =
    echo "ans for ", p, " is ", add(p)

process(5)
process(8)


