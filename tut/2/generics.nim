type
  BinaryTree*[T] = ref object
    le, ri: BinaryTree[T]
    data: T

proc newNode*[T](data: T): BinaryTree[T] =
  new(result)
  result.data = data

proc add*[T](root: var BinaryTree[T], n: BinaryTree[T]) =
  if root == nil:
    root = n
  else:
    var it = root
    while it != nil:
      var c = cmp(it.data, n.data)
      if c < 0:
        if it.le == nil:
          it.le = n
          return
        it = it.le
      else:
        if it.ri == nil:
          it.ri = n
          return
      it = it.ri

proc add*[T](root: var BinaryTree[T], data: T) =
  add(root, newNode(data))


iterator preorder*[T](root: BinaryTree[T]): T =
  var stack: seq[BinaryTree[T]] = @[root]
  while len(stack) > 0:
    var n = pop(stack)
    while n != nil:
      yield n.data
      add(stack, n.ri)
      n = n.le


var
  root: BinaryTree[string]

add(root, newNode("hello"))
add(root, "world")
for str in preorder(root):
  stdout.writeLine(str)
