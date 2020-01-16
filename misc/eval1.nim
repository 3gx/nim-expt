import macros

#macro evalAst1(arg: untyped): untyped =
#  arg
macro evalAst(arg: untyped): untyped =
  let x =
    quote do:
      proc test(x:auto):auto = result = 2*x
      `arg`
  echo x.treeRepr

evalAST:
  let a = 1
  let b = 2
  echo test(a+b)

