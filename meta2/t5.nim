import macros

dumpAstGen:
  echo "hello"
  echo "hi"

macro echoName(x: untyped): untyped =
  let msg = name(x)
  echo msg

proc main(p: int): string {.echoName.} = 
  result = "test"
