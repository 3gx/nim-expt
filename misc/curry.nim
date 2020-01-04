import macros, sequtils, sugar

macro curry_impl(dump: static[bool] = true, fn: untyped): untyped =
  if dump:
    echo fn.repr

  # assert that we expect procDef
  fn.expectKind nnkProcDef

  # extract parameter map
  var params_seq = newSeq[tuple[ty, id, dflt: NimNode]]()
  for p in fn.params[1..<fn.params.len]:
    p.expectKind nnkIdentDefs
    let dflt_val = p[^1]
    let param_ty = p[^2]
    for param_id in p[0..^3]:
      params_seq.add((param_ty, param_id, dflt_val))

  if dump:
    echo map(params_seq,
        proc(p: auto):auto = (p.ty.repr, p.id.repr, p.dflt.repr))

  let getLambda = proc(n: NimNode): auto =
    n.expectKind nnkLetSection
    n[0][2].expectKind nnkLambda
    n[0][2]

  iterator reverse[T](a: seq[T]): T {.inline.} =
    var i = len(a) - 1
    while i > -1:
        yield a[i]
        dec(i)

  var fn1 = fn.body
  for p in reverse(params_seq[0..^1]):
    let id = p.id
    let ty = p.ty
    let dflt = p.dflt
    if dflt == nil:
      fn1 =
        quote do:
          let tmp = proc(`id` : `ty`): auto = `fn1`
    else:
      fn1 =
        quote do:
          let tmp = proc(`id` : `ty` = `dflt`): auto = `fn1`
    fn1 = fn1.getLambda

  let fn_id = fn.name
  result = quote do:
    let `fn_id` = `fn1`
  if dump:
    echo result.repr


macro curry(fn: untyped): untyped =
  quote do:
    curry_impl(false, `fn`)
macro curry_debug(fn: untyped): untyped =
  quote do:
    curry_impl(true, `fn`)

proc fun(x,y:int , z:int = 5):int {.curry.} =
  return x+y*z

proc fun1(x,y:int =3 , z:int = 5, w:int):int {.curry_debug.} =
  result = (x+y*z) * w

echo (((fun 2) 3) 5)
echo fun1()()()(5)

