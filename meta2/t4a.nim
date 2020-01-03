import macros

macro gen_hello(): typed =
  result = nnkStmtList.newTree(
    nnkProcDef.newTree(
      newIdentNode("hello"),
      newEmptyNode(),
      newEmptyNode(),
      nnkFormalParams.newTree(
        newEmptyNode()
      ),
      newEmptyNode(),
      newEmptyNode(),
      nnkStmtList.newTree(
        nnkCommand.newTree(
          newIdentNode("echo"),
          newLit("hi")
        )
      )
    )
  )

gen_hello()
hello()
