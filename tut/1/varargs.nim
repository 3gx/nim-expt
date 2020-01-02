proc myWriteln(a: varargs[string, `$`]) =
  for s in items(a):
    echo s

myWriteln("abc", "def", "xyz", 4)
# is transformed by the compiler to:
#myWriteln(stdout, ["abc", "def", "xyz"])
