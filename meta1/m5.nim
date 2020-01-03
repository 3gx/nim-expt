import json

var j2 =
  %[
    %{
      "name": %"John",
      "age": %30
    },
    %{
      "name": %"Susan",
      "age": %31
    }
  ]

echo j2
