import macros

type
  MyType = object
    a: float
    b: string

macro myMacro(arg: untyped): untyped =
  var mt: MyType = MyType(a:123.456, b:"abcdef")

  # ...

  let mtLit = newLit(mt)

  result = quote do:
    echo `arg`
    echo `mtLit`

myMacro("Hallo")
