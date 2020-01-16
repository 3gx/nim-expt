#https://nim-lang.org/blog/2018/06/07/create-a-simple-macro.html
import macros, sequtils

type
  Edge = tuple[src: string, dst: string]

macro edges(head, body:untyped): untyped =
  template adder(graph, src, dst): untyped =
    graph.add (src,dst)
  result = newStmtList()
  for n in body:
    if n.kind == nnkInfix and $n[0] == "->":
      result.add getAst(adder(head, n[1], n[2]))
  let ast = getAst(adder("graph","src","dst"))
  echo ast.treeRepr
#  echo head.treeRepr
#  echo body.treeRepr

proc buildGraph(): seq[Edge] =
  result = newSeq[Edge]()
  edges(result):
    "Boston" -> "Providence"
    "Boston" -> "New York"
    "Providence" -> "Boston"
    "Providence" -> "New York"

echo buildGraph()

