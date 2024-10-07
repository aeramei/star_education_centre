class Student {
  String name;
  Student(this.name);

  void attendClass() {
    print('$name is attending class.');
  }
}

class Teacher {
  String name;
  List<Student> students = [];
  Teacher(this.name);

  void teach() {
    for (var student in students) {
      print('$name is teaching ${student.name}.');
    }
  }
}

void main() {
  Student student1 = Student('Ingyin');
  Student student2 = Student('AeRa');

  Teacher teacher = Teacher('Mrs. A Mon Oo');
  teacher.students.add(student1);
  teacher.students.add(student2);

  teacher.teach();
  // Output: Mrs. A Mon Oo is teaching Ingyin.  // Mrs. A Mon Oo is teaching AeRa.
}
