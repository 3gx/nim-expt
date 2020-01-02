type
  Node = ref object
    le, ri: Node
    data: int

var n: Node
new(n)
n.data = 9
new(n.le)
n.le.data=42
new(n.ri)
n.le.data=43
