import macros

macro myMacro(arg: static[int]): untyped =
  echo arg

myMacro(1 + 2 * 3)

echo "Hello ":
  let a = "Wor"
  let b = "ld!"
  a & b

dumpTree:
  var mt: MtType = MyType(a:123.456, b:"abcdef")

macro myAssert(arg: untyped): untyped =
  arg.expectKind nnkInfix

dumpTree:
  myAssert(2+3)
