proc echoItem(x: int) = echo x

proc forEach(action: proc (x:int)) =
  const
    data = [2,3,5,7,11]
  for d in items(data):
    action(d)


forEach(echoItem)
