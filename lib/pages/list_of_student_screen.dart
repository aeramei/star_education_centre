import 'package:firebase/classes/methods/student_methods.dart';
import 'package:firebase/classes/student.dart';
import 'package:firebase/pages/student_detail_screen.dart';
import 'package:flutter/material.dart';

class ListOfStudentScreen extends StatefulWidget {
  const ListOfStudentScreen({super.key});

  @override
  State<ListOfStudentScreen> createState() => _ListOfStudentScreenState();
}

class _ListOfStudentScreenState extends State<ListOfStudentScreen> {
  List<Student>? students;
  List<Student>? filteredStudents; // List to store filtered students
  final StudentMethod _studentMethod = StudentMethod();
  TextEditingController _searchController =
      TextEditingController(); // Controller for search bar

  @override
  void initState() {
    _fetchStudents();
    super.initState();
    _searchController
        .addListener(_searchStudents); // Add listener to search bar
  }

  Future<void> _fetchStudents() async {
    students = await _studentMethod.getAllStudents();
    setState(() {
      filteredStudents = students; // Initially show all students
    });
  }

  void _searchStudents() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredStudents = students?.where((student) {
        final studentName = student.name.toLowerCase();
        final studentId = student.id.toLowerCase();
        return studentName.contains(query) || studentId.contains(query);
      }).toList();
    });
  }

  void _editStudent(Student student) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            StudentDetailScreen(student: student),
      ),
    );
  }

  void _deleteStudent(String studentId) {
    _studentMethod.deleteStudent(studentId);
    setState(() {
      students?.removeWhere((student) => student.id == studentId);
      filteredStudents = students; // Update filtered list after deletion
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or ID',
                prefixIcon: Icon(Icons.search, color: Colors.pinkAccent),
                filled: true,
                fillColor: Colors.pink[50],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                ),
              ),
            ),
          ),
          // List of students
          Expanded(
            child: filteredStudents == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredStudents!.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          color: Colors.pink[50],
                          // Light pink background for the list items
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                            title: Text(
                              student.name,
                              style: const TextStyle(
                                color: Colors.pinkAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${student.id}',
                                  style:
                                      const TextStyle(color: Colors.pinkAccent),
                                ),
                                Text(
                                  'Father\'s Name: ${student.fatherName}',
                                  style:
                                      const TextStyle(color: Colors.pinkAccent),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.pinkAccent),
                                  onPressed: () => _editStudent(student),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.pinkAccent),
                                  onPressed: () => _deleteStudent(student.id),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
