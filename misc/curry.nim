import macros, sequtils, sugar

macro curry(fn: untyped): untyped =
  fn.expectKind nnkProcDef
  echo treeRepr(fn)
  # parameter map
  var params_seq = newSeq[tuple[ty, name, dflt: NimNode]]()
  let ret_ty = fn.params[0]
  echo "ret_ty: ", treeRepr(ret_ty)

  for p in fn.params[1..<fn.params.len]:
    p.expectKind nnkIdentDefs
    let dflt_val = p[^1]
    let param_ty = p[^2]
    for param_name in p[0..<p.len-2]:
      params_seq.add((param_ty, param_name, dflt_val))

  echo map(params_seq,
      proc(p: auto):auto = (p.ty.repr, p.name.repr, p.dflt.repr))

  quote do:
    `fn`

proc fun(x,y:int , z:int = 5):int {.curry.} =
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


#dumpAstGen:
#  proc hello() =
#    echo "hi"
#echo xyz(3,4,5)
#
let a = @[1, 2, 3, 4]
let b = map(a, proc (x: auto):auto =  $x)

