import macros


macro echoName(x: untyped): typed =
  for child in x.children():
    if child.kind == nnkProcDef:
      let node = nnkCommand.newTree(newIdentNode("echo"),
                    newLit($name(child)))
      insert(body(child), 0, node)
  result = x;

echoName:
  proc add(p : int) : int =
    result = p + 1

  proc process(p:int) =
    echo "ans for ", p, " is ", add(p)

process(5)
process(8)

