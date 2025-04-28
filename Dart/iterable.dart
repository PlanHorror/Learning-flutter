void main() {
  final studentSixth = Student('Student', 60);
  List<Student> students = [
    Student('First student', 10),
    Student('Second student', 20),
    Student('Third student', 30),
    Student('Fourth student', 40),
    Student('Fifth student', 50),
  ];

  students.add(studentSixth);
  print(students.toSet());
  // List<Student> listStudents = [];
  // for (Student student in students) {
  //   student.marks > 30 ? listStudents.add(student) : null;
  // }
  // print(listStudents);
  students = students.where((Student student) => student.marks > 30).toList();
  print(students);
  print(students.contains(Student('Fourth student', 40)));
  print(students.contains(studentSixth));
  print(students.reversed.toList());
  print(students.firstWhere((Student student) => student.marks > 30));

  Set<Student> setStudents = {
    Student('First student', 10),
    Student('Second student', 20),
    Student('Third student', 30),
    Student('Fourth student', 40),
    Student('Fifth student', 50),
    studentSixth,
    studentSixth,
  };
  print(setStudents);
  // Map<int, String> marks = {10: '10', 20: '20', 30: '30'};
  // marks[40] = '40';
  // Map<int, String> anotherMarks = {50: '50', 60: '60', 70: '70'};
  // marks.addAll(anotherMarks);
  // print(marks);
  // for (int i = 0; i < marks.length; i++) {
  //   print('${marks.keys.toList()[i]} : ${marks.values.toList()[i]}');
  // }
  // marks.forEach((x, y) => print('$x : $y'));
  final Map<String, int> markStudentA = {
    'English': 20,
    'Math': 30,
    'History': 50,
  };
  final List<Map<String, int>> listMarkStudent = [
    {'English': 15, 'Math': 10, 'History': 20},
    {'English': 10, 'Math': 20, 'History': 40},
    markStudentA,
  ];
  print(listMarkStudent);
  listMarkStudent.map((e) {
    print(e);
    return e.forEach((k, v) => print('$k : $v'));
  });
}

class Student {
  final String name;
  final int marks;

  Student(this.name, this.marks);

  @override
  String toString() {
    // TODO: implement toString
    return 'Student ${this.name}';
  }
}
