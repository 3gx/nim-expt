import json, macros

var j2 =
  %[
    %{
      "name": %"John",
      "age": %30
    },
    %{
      "name": %"Susan",
      "age": %31
    }
  ]

echo j2

dumpLisp:
  %[
    %{
      "name": %"John",
      "age": %30
    },
    %{
      "name": %"Susan",
      "age": %31
    }
  ]

dumpLisp:
  Mfor

var j1 = %*
  [
    {
      "name": "John",
      "age": 30
    },
    {
      "name": "Susan",
      "age": 31
    }
  ]

echo j1
dumpLisp:
 %*
  [
    {
      "name": "John",
      "age": 30
    },
    {
      "name": "Susan",
      "age": 31
    }
  ]

proc toJson(x: NimNode): NimNode {.compiletime.} =
  case x.kind
  of nnkBracket: # Corresponds to Bracket in dumpTree
    result = newNimNode(nnkBracket)
    for i in 0..<x.len:
      result.add(toJson(x[i])) # Recurse to add %

  of nnkTableConstr: # nnk stands for Nim node kind
    result = newNimNode(nnkTableConstr)
    for i in 0..<x.len:
      assert x[i].kind == nnkExprColonExpr
      result.add(newNimNode(nnkExprColonExpr)
        .add(x[i][0])           # First element: no %
        .add(toJson(x[i][1]))): # Second element: Recurse to add %

  else:
    result = x # End of recursion

  result = result.prefix("%") # Surround this level with %

macro `$*`*(x: untyped): untyped =
  result = toJson(x)
  echo result.repr

var j3 = $*
  [
    {
      "name": "John",
      "age": 30
    },
    {
      "name": "Susan",
      "age": 31
    }
  ]
echo j3

