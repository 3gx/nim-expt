type
  Person = ref object of RootObj
    name: string
    age: int

  Student = ref object of Person
    id: int

var
  student: Student
  person: Person

assert(student of Person)
assert(student of Student)
assert(person of Person)
# assert(person of Student) # is false

student = Student(name: "Anton", age: 5, id: 2)
echo student[]

