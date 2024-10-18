import 'package:firebase/classes/course.dart';
import 'package:firebase/classes/enrollment_record.dart';
import 'package:firebase/classes/methods/student_methods.dart';
import 'package:firebase/classes/student.dart';
import 'package:firebase/reusable_widgets/course_selection_dialog.dart';
import 'package:firebase/sections.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentDetailScreen extends StatefulWidget {
  StudentDetailScreen({super.key, required this.student});

  final Student student;

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _fatherNameController;
  List<Course> enrolledCourses = [];

  DateTime? _dob;
  String _selectedGender = 'Male';
  String _selectedSection = '';

  StudentMethod _studentMethod = StudentMethod();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with student data
    _nameController = TextEditingController(text: widget.student.name);
    _emailController = TextEditingController(text: widget.student.email);
    _phoneController = TextEditingController(text: widget.student.phone);
    _fatherNameController =
        TextEditingController(text: widget.student.fatherName);

    _dob = widget.student.DOB;
    _selectedGender = widget.student.gender;
    _selectedSection = widget.student.sectionId;

    for (EnrollmentRecord er in widget.student.enrollmentRecords) {
      enrolledCourses.add(er.course);
    }
  }

  // Function to pick date of birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CourseSelectionDialog(
        student: widget.student,
        enrolledCourses: enrolledCourses,
      ),
    );
  }

  // Function to handle saving student details
  void _saveStudentDetails() {
    if (_formKey.currentState!.validate()) {
      widget.student.name = _nameController.text;
      widget.student.email = _emailController.text;
      widget.student.phone = _phoneController.text;
      widget.student.fatherName = _fatherNameController.text;
      widget.student.DOB = _dob!;
      widget.student.gender = _selectedGender;
      widget.student.sectionId = _selectedSection;

      _studentMethod.updateStudent(widget.student);

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student details updated successfully!'),
          backgroundColor: Colors.pinkAccent,
        ),
      );
    }
  }

  Widget _buildEnrollmentRecordsList() {
    if (widget.student.enrollmentRecords.isEmpty) {
      return const Center(
        child: Text(
          'No courses enrolled yet.',
          style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.student.enrollmentRecords.length,
      itemBuilder: (context, index) {
        EnrollmentRecord enrollment = widget.student.enrollmentRecords[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(enrollment.course.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                )),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Discount: ${enrollment.discountPercent.toStringAsFixed(2)}%'),
                Text(
                    'Final Price: ${enrollment.finalPrice.toStringAsFixed(2)} MMK'),
                Text(
                    'Enrolled on: ${DateFormat('yyyy-MM-dd').format(enrollment.recordTime)}'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'Student Details',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Full Name input
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent),
                          ),
                        ),
                        style: const TextStyle(color: Colors.pinkAccent),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the student\'s name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Date of Birth input
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.pinkAccent)),
                            ),
                            child: Text(
                              _dob != null
                                  ? DateFormat('yyyy-MM-dd').format(_dob!)
                                  : 'Select Date of Birth',
                              style: TextStyle(
                                color: _dob != null
                                    ? Colors.pinkAccent
                                    : Colors.pinkAccent.withOpacity(0.5),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Gender dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                        ),
                        items: ['Male', 'Female', 'Other'].map((gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                        style: const TextStyle(color: Colors.pinkAccent),
                      ),
                      const SizedBox(height: 10),

                      // Email input
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent),
                          ),
                        ),
                        style: const TextStyle(color: Colors.pinkAccent),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the student\'s email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Phone Number input
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent),
                          ),
                        ),
                        style: const TextStyle(color: Colors.pinkAccent),
                      ),
                      const SizedBox(height: 10),

                      // Father's Name input
                      TextFormField(
                        controller: _fatherNameController,
                        decoration: const InputDecoration(
                          labelText: 'Father\'s Name',
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent),
                          ),
                        ),
                        style: const TextStyle(color: Colors.pinkAccent),
                      ),
                      const SizedBox(height: 10),

                      // Section dropdown
                      DropdownButtonFormField<String>(
                        value:
                            _selectedSection.isEmpty ? null : _selectedSection,
                        hint: const Text('Select Section',
                            style: TextStyle(color: Colors.pinkAccent)),
                        items: courseSections.map((section) {
                          return DropdownMenuItem(
                            value: section.name,
                            child: Text(section.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSection = value!;
                          });
                        },
                        style: const TextStyle(color: Colors.pinkAccent),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a section';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Save button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                        ),
                        onPressed: _saveStudentDetails,
                        child: const Text('Save Details'),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink.shade50,
                        ),
                        onPressed: _showDialog,
                        child: const Text(
                          'Enroll Course',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // List of Enrollment Records
                      const Text(
                        'Enrolled Courses',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      const SizedBox(height: 10),

                      _buildEnrollmentRecordsList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
