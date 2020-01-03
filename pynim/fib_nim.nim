import math, strformat, times, nimpy

proc fib(n: int): int {.exportpy.} =
  if n <= 2:
    return 1
  else:
    return fib(n-1) + fib(n-2)

when isMainModule:
  let x = 38
  let start = epochTime()
  let res = fib(x)
  let elapsed = (epochtime() - start).round(2)
  stderr.writeLine(&"Nim Computed fib({x})={res} in {elapsed} seconds")

#nim c -d:release --app:lib --gc:regions --out:fib_nimpy.so fib_nim.nim
