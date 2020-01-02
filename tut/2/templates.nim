template `!=` (a,b: untyped): untyped = 
  not (a==b)

assert (5 != 6)

const
  debug = true

template log(msg: string) =
  if debug: stdout.writeLine(msg)

var x = 4

log("x has value " & $x)

template withFile(f: untyped, filename: string, mode: FileMode,
                  body: untyped) =
  let fn = filename
  var f: File
  if open(f, fn, mode):
    try:
      body
    finally:
      close(f)
  else:
    quit("cannot open: " & fn)

withFile(txt, "ttemp3.txt", fmWrite):
  txt.writeLine("line1")
  txt.writeLine("line2")

import math

template liftScalarproc(fname) =
    proc fname[T](x: openArray[T]): auto =
      var temp: T
      type outType = type(fname(temp))
      result = newSeq[outType](x.len)
      for i in 0..<x.len:
        result[i] = fname(x[i])

liftScalarProc(sqrt)
echo sqrt(@[4.0, 16.0, 25.0, 36.0])

