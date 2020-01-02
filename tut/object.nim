type
  Person = object
    name: string
    age: int

  Vehicle = object
    name: string
    age: int

var person1 = Person(name: "Peter", age: 30)

var vehicle1 = Vehicle(name: "Mazda3", age: 5)

echo person1.name # "Peter"
echo person1.age  # 30

echo vehicle1.name # "Peter"
echo vehicle1.age  # 30


