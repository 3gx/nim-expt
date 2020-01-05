import macros

macro foo(): untyped =
  let a = @[1, 2, 3, 4, 5]
  result = quote do:
    `a.len`

echo foo() # Outputs @[1, 2, 3, 4, 5] instead of 5

