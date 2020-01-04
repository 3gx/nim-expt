import macros, sequtils, sugar

macro curry(fn: untyped): untyped =
  const dump= true
  # assert that we expect procDef 
  fn.expectKind nnkProcDef

  #if dump:  echo treeRepr(fn)

  # proc return type
  let ret_ty = fn.params[0]

  # extract parameter map
  var params_seq = newSeq[tuple[ty, name, dflt: NimNode]]()
  for p in fn.params[1..<fn.params.len]:
    p.expectKind nnkIdentDefs
    let dflt_val = p[^1]
    let param_ty = p[^2]
    for param_name in p[0..^3]:
      params_seq.add((param_ty, param_name, dflt_val))

  if dump:
    echo map(params_seq,
        proc(p: auto):auto = (p.ty.repr, p.name.repr, p.dflt.repr))

  let p = params_seq[^1]
  let nm = p.name
  let ty = p.ty
  let fbody = fn.body
  let last =
    quote do:
      let tmp = proc(`nm` : `ty`): auto = `fbody`
  echo treeRepr(last)
  fn


proc fun(x,y:int , z:int = 5):int {.curry.} =
  result = x+y*z

let t1 = proc(x:int): auto =
  return proc (y:int): auto =
    return proc (z: int): auto = fun(x,y,z)

let t = proc(x:int): int = x*2

#echo cfun(3)(4)(5)
#dumpLisp:
#  proc xxx(x,y:int, z:int): int = x*2

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

