import 'package:flutter/material.dart';
import 'package:mhk_star_education/classes/methods/student_methods.dart';
import 'package:mhk_star_education/classes/student.dart';
import 'package:mhk_star_education/pages/student_detail_page.dart';
import 'package:mhk_star_education/utils/logout_button.dart';
import 'package:mhk_star_education/utils/status_show.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final StudentMethods _studentMethods = StudentMethods();
  List<Student> _students = [];
  List<Student> _filteredStudents = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    try {
      List<Student> students = await _studentMethods.get();
      setState(() {
        _students = students;
        _filteredStudents = students; // Initially, show all students
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching students: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterStudents(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredStudents = _students.where((student) {
        return student.name.toLowerCase().contains(_searchQuery) ||
            student.studentId.toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }

  Future<void> _handleDelete(String studentId) async {
    bool status = await _studentMethods.deleteStudent(studentId);
    if (status) {
      setState(() {
        _students.removeWhere((student) => student.studentId == studentId);
        _filteredStudents.removeWhere((student) => student.studentId == studentId);
      });
      StatusShow(context, "Student deleted!");
    } else {
      StatusShow(context, "Error: Student deletion failed!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: const [
          LogoutButton()
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                onChanged: _filterStudents,
                decoration: InputDecoration(
                  labelText: 'Search by Name or ID',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredStudents.isEmpty
                  ? const Center(child: Text('No students found'))
                  : Expanded(
                child: ListView.builder(
                  itemCount: _filteredStudents.length,
                  itemBuilder: (context, index) {
                    Student student = _filteredStudents[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(student.email),
                                Text('Section: ${student.section}'),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentDetailPage(
                                                student: student),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    _handleDelete(student.studentId);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
