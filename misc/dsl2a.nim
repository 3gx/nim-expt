# https://peterme.net/metaprogramming-and-read-and-maintainability-in-nim.html

import math, strutils
import macros

macro defineCommands(enumName, docarrayName, runnerName,
                     definitions: untyped): untyped =
  var
    enumDef = nnkTypeSection.newTree(
      nnkTypeDef.newTree(
        enumName,
        newEmptyNode(),
        nnkEnumTy.newTree(newEmptyNode())))
    docstrings =  nnkConstSection.newTree(
      nnkConstDef.newTree(
        docarrayName,
        nnkBracketExpr.newTree(
          newIdentNode("array"),
          enumName,
          newIdentNode("string")
        ),
        nnkBracket.newTree()))
    templateArgument = newIdentNode("command")
    caseSwitch =  nnkCaseStmt.newTree(
      nnkCall.newTree(
        nnkBracketExpr.newTree(
          newIdentNode("parseEnum"),
          enumName
        ),
        templateArgument))
  for i in countup(0, definitions.len - 1, 2):
    let
      enumInfo = definitions[i]
      commandInfo = definitions[i+1]
    enumDef[0][2].add nnkEnumFieldDef.newtree(enumInfo[0], enumInfo[1])
    docstrings[0][2].add commandInfo[0]
    caseSwitch.add nnkOfBranch.newTree(
      enumInfo[0],
      commandInfo[1])
  result = quote do:
    `enumDef`
    `docstrings`
    template `runnerName`(`templateArgument`: untyped): untyped =
      `caseSwitch`
  echo result.repr

defineCommands(Commands, docstrings, runCommand):
  Plus = "+"; "Adds two numbers":
    stack.execute(a + b)
  Minus = "-"; "Subtract two numbers":
    stack.execute(b - a)
  Multiply = "*"; "Multiplies two numbers":
    stack.execute(a * b)
  Divide = "/"; "Divides two numbers":
    stack.execute(b / a)
  Pop = "pop"; "Pops a number off the stack":
    discard stack.pop
  StackSwap = "swap"; "Swaps the two bottom elements on the stack":
    let
      a = stack[^1]
      b = stack[^2]
    stack[^1] = b
    stack[^2] = a
  StackRotate = "rot"; "Rotates the stack one level":
    stack.insert(stack.pop, 0)
  Help = "help"; "Lists all the commands with documentation":
    echo "Commands:"
    for command in Commands:
      echo "\t", command, "\t", docstrings[command]
  Exit = "exit"; "Exits the program":
    quit 0

echo docstrings

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


# Program main loop, read input from stdin, run our template to parse the
# command and run the corresponding operation. if that fails try to push it as
# a number. Print out our "stack" for every iteration of the loop
while true:
  for command in stdin.readLine.split(" "):
    try:
      runCommand(command)
    except:
      stack.push parseFloat(command)
    echo stack, " - ", command
