import macros

macro dumpAST(arg: untyped): untyped =
  echo arg.treeRepr


dumpAST:
  let a = 1
  let b = 2
  a != b
