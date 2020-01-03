import macros

macro gen_hello(): typed =
  let source = """
  proc hello() =
    echo "hi"
  """
  result = parseStmt(source)

gen_hello()
hello()
