void main() {
  print(new Employee('John', EmployeeType.SWE));
}

enum EmployeeType {
  SWE(2000),
  FN(10000);

  final int salary;
  const EmployeeType(this.salary);
}

class Employee {
  final String name;
  final EmployeeType type;
  Employee(this.name, this.type);
  @override
  String toString() {
    // TODO: implement toString
    return 'Name: $name \nType: ${type.name} \nSalary: ${type.salary}';
  }
}
