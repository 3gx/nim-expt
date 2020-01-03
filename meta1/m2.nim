import strutils, times, os

type Level* {.pure.} = enum
  debug, info, warn, error, fatal

var logLevel* = Level.debug

template debug*(args: varargs[string, `$`]) =
  if logLevel <= Level.debug:
    const module = instantiationInfo().filename[0..^5]
    echo "[$# $#] [$#]: $#" % [getDateStr(), getClockStr(), module, join args]


proc expensiveDebuggingInfo*: string =
  sleep(milsecs = 1000)
  result = "Everything looking good!"

debug expensiveDebuggingInfo()

