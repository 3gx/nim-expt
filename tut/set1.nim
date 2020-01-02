type
  CharSet = set[char]
var
  x: CharSet
x = {'a'..'z', '0'..'9'}

for c in x:
  echo c
