import macros, sequtils, sugar

# macro impl that can print debug info
macro curry_impl(dump: static[bool] = true, fn: untyped): untyped =
  if dump:
    echo fn.repr

  # assert that we expect procDef
  fn.expectKind nnkProcDef

  # extract parameter map
  var params_seq = newSeq[tuple[ty, id, dflt: NimNode]]()
  for p in fn.params[1..<fn.params.len]:
    p.expectKind nnkIdentDefs
    let param_ty = p[^2]
    let dflt_val = p[^1]
    # loop through all parameters to get their identifier
    for param_id in p[0..^3]:
      params_seq.add((param_ty, param_id, dflt_val))

  if dump:
    echo map(params_seq,
        proc(p: auto):auto = (p.ty.repr, p.id.repr, p.dflt.repr))

  # helper to get lambda from Let expr constructed below
  let getLambdaFromLet = proc(n: NimNode): auto =
    n.expectKind nnkLetSection
    n[0][2].expectKind nnkLambda
    n[0][2]

  # helper reverse iterator to traverse list in reverse
  iterator reverse[T](a: seq[T]): T {.inline.} =
    var i = len(a) - 1
    while i > -1:
        yield a[i]
        dec(i)

  var fn1 = fn.body
  for p in reverse(params_seq[0..^1]):
    # XXX: WAR for https://github.com/nim-lang/Nim/issues/7726
    let
      id = p.id
      ty = p.ty
      dflt = p.dflt

    # Generate let binding for lambda accepting one parameter
    fn1 =
      if dflt == nil: quote do:
        let t = proc(`id` : `ty`): auto = `fn1`
      else: quote do:
        let t= proc(`id` : `ty` = `dflt`): auto = `fn1`
    # extract lambda from let binding
    fn1 = fn1.getLambdaFromLet

  # WAR for issue Nim/issues/7726
  let fn_id = fn.name

  # Generate final lambda for curried function
  result = quote do:
    let `fn_id` = `fn1`
  if dump:
    echo result.repr


# silient macro
macro curry(fn: untyped): untyped =
  quote do:
    curry_impl(false, `fn`)

# macro with debug prints
macro curry_debug(fn: untyped): untyped =
  quote do:
    curry_impl(true, `fn`)

# curry function
proc fun(x,y:int , z:int = 5):int {.curry.} =
  return x+y*z

proc fun1(x,y:int =3 , z:int = 5, w:int):int {.curry_debug.} =
  result = (x+y*z) * w

echo (((fun 2) 3) 5)
echo ((fun 2) 3)()
echo fun1()()()(5)

