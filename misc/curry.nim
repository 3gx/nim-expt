import macros

macro curry(fn: untyped): untyped =
  fn.expectKind nnkProcDef
  fn.name= newIdentNode("xyz")
#  echo lispRepr(fn[0], indented=true)
#  result = fn
  quote do:
    `fn`

proc fun(x,y,z:int):int {.curry.} =
  result = x+y*z

#proc cfun(x:int): auto =
#  return proc (y:int): auto =
#    return proc (z: int): auto = fun(x,y,z)

let t = proc(x:int): int = x*2

#echo cfun(3)(4)(5)
#dumpLisp:
#  let t = proc(x:int): int = x*2

proc map(str: string, fun: proc (x:char) : char): string =
  for c in str:
    result &= fun(c)


dumpAstGen:
  proc hello() =
    echo "hi"

echo xyz(3,4,5)
