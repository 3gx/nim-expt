import macros, sugar

macro foo(): untyped =
  let a = @[1, 2, 3, 4, 5]
#  proc t(n:auto): auto = a[^n]
#  let x = t 4
  result = quote do:
    `a.len`

echo foo() # Outputs @[1, 2, 3, 4, 5] instead of 5

proc f1(f: auto , n:int): int =
  result = f(n,13)

proc addx[T](n: T, m: T) : T =
  result = m + n

echo f1( (n:int,m:int) => m+n, 42)
echo f1( addx[int], 42)

