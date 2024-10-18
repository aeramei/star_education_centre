import 'package:firebase/classes/course.dart';
import 'package:firebase/classes/enrollment_record.dart';
import 'package:firebase/classes/methods/enroll_record_methods.dart';
import 'package:firebase/classes/methods/student_methods.dart';
import 'package:firebase/classes/student.dart';
import 'package:firebase/courses.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CourseSelectionDialog extends StatefulWidget {
  const CourseSelectionDialog(
      {super.key, required this.student, this.enrolledCourses});

  final Student student;
  final List<Course>? enrolledCourses; // List of already enrolled courses

  @override
  _CourseSelectionDialogState createState() => _CourseSelectionDialogState();
}

class _CourseSelectionDialogState extends State<CourseSelectionDialog> {
  final Map<String, bool> _selectedCoursesId = {};
  final List<Course> _selectedCourse = [];
  final EnrollRecordMethod _enrollRecordMethod = EnrollRecordMethod();
  final StudentMethod _studentMethod = StudentMethod();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize the selection status of courses
    for (var course in programmingCourses) {
      _selectedCoursesId[course.id] = false;
    }
  }

  Future<void> enrollCourse() async {
    setState(() {
      _isLoading = true; // Show progress bar
    });

    // Clone the enrollmentRecords list to make it mutable
    List<EnrollmentRecord> enrollmentRecords =
        List.from(widget.student.enrollmentRecords);

    for (Course course in _selectedCourse) {
      EnrollmentRecord temporaryER = EnrollmentRecord(
        id: const Uuid().v1(),
        recordTime: DateTime.now(),
        course: course,
      );

      EnrollmentRecord newEnrollmentRecord =
          EnrollmentRecord.EnrollmentRecordFactory(
        temporaryER,
        enrollmentRecords.length,
      );

      enrollmentRecords.add(newEnrollmentRecord);
    }

    widget.student.enrollmentRecords = enrollmentRecords;

    // Update student in database
    bool success = await _studentMethod.updateStudent(widget.student);

    setState(() {
      _isLoading = false; // Hide progress bar
    });

    // Show status message and pop dialog
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(success ? 'Enrollment successful!' : 'Enrollment failed!'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );

    // Reset selection and state
    _selectedCoursesId.clear();
    _selectedCourse.clear();
    for (var course in programmingCourses) {
      _selectedCoursesId[course.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Courses'),
      content: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...programmingCourses.where((course) {
                    return widget.enrolledCourses == null ||
                        !widget.enrolledCourses!.any(
                            (enrolledCourse) => enrolledCourse.id == course.id);
                  }).map(
                    (course) => CheckboxListTile(
                      title: Text(course.name),
                      subtitle:
                          Text('Fees: ${course.fees.toStringAsFixed(2)} MMK'),
                      value: _selectedCoursesId[course.id],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedCoursesId[course.id] = value ?? false;
                          if (value == true) {
                            _selectedCourse.add(course);
                          } else {
                            _selectedCourse.remove(course);
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  ),
                ],
              ),
            ),
      actions: _isLoading
          ? []
          : [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: enrollCourse,
                child: const Text('Attend'),
              ),
            ],
    );
  }
}
