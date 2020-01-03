import macros, strutils


template write(arg: untyped) =
  result.add newCall("add", newIdentNode("result"), arg)

template writeLit(args: varargs[string, `$`]) =
  write newStrLitNode(args.join)

proc htmlInner(x: NimNode, indent = 0): NimNode {.compiletime.} =
  x.expectKind nnkStmtList
  result = newStmtList()
  let spaces = repeat(' ', indent)
  for y in x:
    case y.kind
    of nnkCall:
      y.expectLen 2
      let tag = y[0]
      tag.expectKind nnkIdent
      writeLit spaces, "<", tag, ">\n"
      # Recurse over child
      result.add htmlInner(y[1], indent + 2)
      writeLit spaces, "</", tag, ">\n"
    else:
      writeLit spaces
      write y
      writeLit "\n"

macro htmlTemplate(procDef: untyped): untyped =
  procDef.expectKind nnkProcDef

  # Same name as specified
  let name = procDef[0]

  # Return type: string
  var params = @[newIdentNode("string")]

  # Same parameters as specified
  for i in 1..<procDef[3].len:
    params.add procDef[3][i]

  var body = newStmtList()

  body.add newAssignment(newIdentNode("result"),
                         newStrLitNode(""))
  body.add htmlInner(procDef[6])

  result = newStmtList(newProc(name, params, body))

proc page(title, content: string)  {.htmlTemplate.} =
  html:
    head:
      title: title
    body:
      h1: title
      p: "Default Content"
      p: content

echo page("My own website", "My extra content")
