import 'package:firebase/classes/methods/student_methods.dart';
import 'package:firebase/classes/student.dart';
import 'package:firebase/reusable_widgets/course_selection_dialog.dart';
import 'package:firebase/sections.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({super.key});

  @override
  State<RegisterStudentScreen> createState() => _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentId = const Uuid().v1();

  // Controllers to capture form inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final StudentMethod _studentMethod = StudentMethod();
  Student? newStudent;

  DateTime? _dob;
  String _selectedGender = 'Male';
  String _selectedSection = '';

  // Function to pick date of birth
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }

  // Function to handle student registration
  void _registerStudent() {
    if (_formKey.currentState!.validate()) {
      newStudent = Student(
        id: _studentId,
        name: _nameController.text,
        DOB: _dob!,
        gender: _selectedGender,
        email: _emailController.text,
        phone: _phoneController.text,
        fatherName: _fatherNameController.text,
        sectionId: _selectedSection,
      );

      _studentMethod.createStudent(newStudent!);

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student registered successfully!'),
          backgroundColor: Colors.pinkAccent,
        ),
      );

      _resetData();

      showDialog(
        context: context,
        builder: (BuildContext context) => CourseSelectionDialog(
          student: newStudent!,
        ),
      );
    }
  }

  // Function to reset the form data
  void _resetData() {
    setState(() {
      _nameController.text = '';
      _dob = null;
      _selectedGender = 'Male';
      _emailController.text = '';
      _phoneController.text = '';
      _fatherNameController.text = '';
      _selectedSection = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New Student'),
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
                          'Student Registration Form',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // Name input
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
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.pinkAccent),
                              ),
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
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem(
                                value: gender, child: Text(gender)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value ?? 'Male';
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

                      // Phone input
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
                        decoration: const InputDecoration(
                          labelText: 'Section',
                          labelStyle: TextStyle(color: Colors.pinkAccent),
                        ),
                        value:
                            _selectedSection.isEmpty ? null : _selectedSection,
                        hint: const Text('Select Section',
                            style: TextStyle(color: Colors.pinkAccent)),
                        items: courseSections.map((section) {
                          return DropdownMenuItem(
                            value: section.name,
                            child: Text(section.name,
                                style:
                                    const TextStyle(color: Colors.pinkAccent)),
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

                      // Submit button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.pinkAccent, // Light pink button
                        ),
                        onPressed: _registerStudent,
                        child: const Text('Register Student'),
                      ),
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
