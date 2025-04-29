void main() {
  final a = (2, false, name: "Name", age: 12);
  final c = a.name;
  print(c);
  final jsonded = {"userId": 1, "Name": "Name", "age": 20};
  final {"age": age2} = jsonded;
  print(age2);
  final student = Student(name: "First", age: 20);
  final Student(:name, :age) = student;
  print('Name: $name, Age: $age');
}

class Student {
  final String name;
  final int age;
  Student({required this.name, required this.age});
}
