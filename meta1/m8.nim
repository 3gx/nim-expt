import macros

macro genRepeatEcho(): untyped =
  result = newNimNode(nnkStmtList)
  
  var forStmt = newNimNode(nnkForStmt) # generate a for statement
  forStmt.add(ident("i")) # use the variable `i` for iteration
  
  var rangeDef = newNimNode(nnkInfix).add(
    ident("..")).add(
    newIntLitNode(3),newIntLitNode(5)) # iterate over the range 3..5
  
  forStmt.add(rangeDef)
  forStmt.add(newCall(ident("echo"), newIntLitNode(3))) # meat of the loop
  result.add(forStmt)

genRepeatEcho() # gives:
                # 3
                # 3
                # 3

template decorator(argument: untyped) =
  echo "This mimics a Decorator: enter"
  argument
  echo "This mimics a Decorator: exit"

func function_with_decorator(): int {.decorator.} =
  return 42

echo function_with_decorator()
