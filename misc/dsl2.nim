# https://peterme.net/metaprogramming-and-read-and-maintainability-in-nim.html

import math, strutils

# We define an enum with our built in commands
type
  Commands = enum
    Plus = "+", Minus = "-", Multiply = "*", Divide = "/", Pop = "pop",
    StackSwap = "swap", StackRotate = "rot", Help = "help", Exit = "exit"

# Give them some documentation strings
const docstrings: array[Commands, string] = [
  "Adds two numbers",
  "Subtract two numbers",
  "Multiplies two numbers",
  "Divides two numbers",
  "Pops a number off the stack",
  "Swaps the two bottom elements on the stack",
  "Rotates the stack one level",
  "Lists all the commands with documentation",
  "Exits the program"
]

# Then create a simple "stack" implementation
var stack: seq[float]

proc push[T](stack: var seq[T], value: T) =
  stack.add value

proc pop[T](stack: var seq[T]): T =
  result = stack[^1]
  stack.setLen(stack.len - 1)

# Convenience template to execute an operation over two operands from the stack
template execute[T](stack: var seq[T], operation: untyped): untyped {.dirty.} =
  let
    a = stack[^1]
    b = stack[^2]
  stack.setLen(stack.len - 2)
  stack.push(operation)

# Program main loop, read input from stdin, try to parse it as a command and
# run it's corresponding operation, if that fails try to push it as a number.
# Print out our "stack" for every iteration of the loop
while true:
  for command in stdin.readLine.split(" "):
    try:
      case parseEnum[Commands](command):
      of Plus: stack.execute(a + b)
      of Minus: stack.execute(b - a)
      of Multiply: stack.execute(a * b)
      of Divide: stack.execute(b / a)
      of Pop: discard stack.pop
      of StackSwap:
        let
          a = stack[^1]
          b = stack[^2]
        stack[^1] = b
        stack[^2] = a
      of StackRotate:
        stack.insert(stack.pop, 0)
      of Help:
        echo "Commands:"
        for command in Commands:
          echo "\t", command, "\t", docstrings[command]
      of Exit: quit 0
    except:
      stack.push parseFloat(command)
    echo stack, " - ", command

