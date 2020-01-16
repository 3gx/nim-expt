import macros 

macro eval1(fun: untyped): untyped  =
  fun.expectKind nnkProcDef
  let body = fun.body
  let stmt = body[0]
  echo stmt.treeRepr
  let e =
    quote do:
      let x = 42
      let y = `stmt`
  echo e.treeRepr


proc stmt1 {.eval1.}=
  2*x

