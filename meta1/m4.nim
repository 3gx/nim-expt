import macros

dumpTree:
  result = 10

static:
  echo treeRepr(parseStmt("result = 10"))

static:
  echo lispRepr(parseStmt("result = 10"))


