import macros

macro myAssert(arg: untyped): untyped =
  arg.expectKind nnkInfix
  arg.expectLen 3

  let op = newLit(" " & arg[0].repr & " ")
  let lhs = arg[1]
  let rhs = arg[2]

  echo "op= ", op, " |-| ", arg[0]
  echo "lhs= ", lhs
  echo "rhs= ", rhs

  result = quote do:
    dumpTree:
      `arg`
    if not `arg`:
      raise newException(AssertionError, $`lhs` & " |-" & `op` & "-| " & $`rhs`)


let a = 1
let b = 2

myAssert(a != b)
myAssert(a == b)

