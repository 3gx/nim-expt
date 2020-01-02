var
  a = "Nim is a progamming language"
  b = "Slices are useless."

echo a[7..12] # --> 'a prog'
echo len(b)
b[11..^2] = "useful"
echo b # --> 'Slices are useful.
echo len(b)
