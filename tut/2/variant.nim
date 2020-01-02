type
  NodeKind = enum
    nkInt,
    nkFloat,
    nkString
    nkIf
  Node = ref object
    case kind: NodeKind
      of nkInt: intVal: int
      of nkFloat : floatVal: float
      of nkString : strVal: string
      of nkIf: condition, thenPart, elsePart: Node


var n = Node(kind: nkFloat, floatVal: 1.0)

echo n.floatVal
# echo n.strVal # raises FieldError exception

