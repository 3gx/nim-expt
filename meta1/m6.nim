import macros, strutils

type Fruit = enum Apple, Banana, Cherry

let fruit = parseEnum[Fruit]("cherry")
echo fruit

#for i in 1 .. 10_000_000:
#  var select = parseEnum[Fruit]("cherry")
#  doAssert select == Cherry
#
proc parseEnum1*[T: enum](s: string): T =
  macro m: auto =
#    m.expectKind nnkInfix
    result = newStmtList()
    for e in T: result.add parseStmt(
      "if cmpIgnoreStyle(s, \"$1\") == 0: return $1".format(e))
    result.add parseStmt(
          "raise newException(ValueError, \"invalid enum value: \"&s)")
    echo result.lispRepr(indented=true)
  m()




let fruit1 = parseEnum1[Fruit]("cherry")
echo fruit1
#for i in 1 .. 10_000_000:
#  var select = parseEnum1[Fruit]("cherry")
#  doAssert select == Cherry
