import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mhk_star_education/classes/course.dart';
import 'package:mhk_star_education/classes/enrollment_record.dart';
import 'package:mhk_star_education/classes/methods/enroll_record_methods.dart';
import 'package:mhk_star_education/classes/methods/student_methods.dart';
import 'package:mhk_star_education/classes/student.dart';
import 'package:mhk_star_education/static_data.dart';
import 'package:mhk_star_education/utils/status_show.dart';
import 'package:mhk_star_education/utils/widget_text_field.dart';

class StudentDetailPage extends StatefulWidget {
  final Student student; // Pass the student object to this page
  const StudentDetailPage({super.key, required this.student});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCon;
  late TextEditingController _emailCon;
  late TextEditingController _phoneCon;
  late TextEditingController _addressCon;
  String? _gender;
  String? _sectionValue;

  final List<Course> _selectedCourses = [];
  final List<Course> _availableCourses = [];
  final List<Course> _newSelectedCourses = [];
  double _totalCourseFees = 0;
  double discount = 0;

  final EnrollMethods _enrollMethods = EnrollMethods();

  @override
  void initState() {
    super.initState();
    // Pre-populate the data from the passed Student object
    _nameCon = TextEditingController(text: widget.student.name);
    _emailCon = TextEditingController(text: widget.student.email);
    _phoneCon = TextEditingController(text: widget.student.phone);
    _addressCon = TextEditingController(text: widget.student.address);
    _gender = widget.student.gender;
    _sectionValue = widget.student.section;

    // Initialize the selected courses from the passed student object
    _selectedCourses.addAll(widget.student.courses);

    _availableCourses.addAll(courses);

    _updateDiscount();
  }

  @override
  void dispose() {
    _nameCon.dispose();
    _emailCon.dispose();
    _phoneCon.dispose();
    _addressCon.dispose();
    super.dispose();
  }

  void _updateDiscount() {
    setState(() {
      if (_selectedCourses.length >= 3) {
        discount = 20;
      } else if (_selectedCourses.length == 2) {
        discount = 10;
      } else if (_selectedCourses.length == 1) {
        discount = 5;
      } else {
        discount = 0;
      }
    });
  }

  void _updateTotalFee() {
    setState(() {
      _totalCourseFees = 0;
      for (Course course in _newSelectedCourses) {
        _totalCourseFees += course.courseFee;
      }
    });
  }

  Future<void> updateStudent() async {
    if (_formKey.currentState!.validate()) {
      StudentMethods studentMethods = StudentMethods();

      // Update the student object with the new values
      Student updatedStudent = Student(
        widget.student.studentId,
        name: _nameCon.text,
        email: _emailCon.text,
        phone: _phoneCon.text,
        address: _addressCon.text,
        section: _sectionValue!,
        registerDate: widget.student.registerDate,
        gender: _gender!,
        courses: widget.student.courses,
      );

      bool response = await studentMethods.updateStudent(updatedStudent);
      if (response) {
        StatusShow(context, "Student Updated Successfully");
        bool status = await studentMethods.enrollCourses(
            updatedStudent, _selectedCourses);
        if (status) {
          _updateDiscount();
        }
      } else {
        StatusShow(context, "Update Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Student Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.lightBlueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    WidgetTextField(
                      controller: _nameCon,
                      hintText: 'Full Name',
                      borderColor: Colors.teal,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student\'s full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WidgetTextField(
                      controller: _emailCon,
                      hintText: 'Email',
                      borderColor: Colors.teal,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student\'s email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WidgetTextField(
                      controller: _phoneCon,
                      hintText: 'Phone Number',
                      borderColor: Colors.teal,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student\'s phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WidgetTextField(
                      controller: _addressCon,
                      hintText: 'Address',
                      borderColor: Colors.teal,
                      minLines: 2,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student\'s address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _sectionValue,
                      decoration: const InputDecoration(
                        labelText: 'Section',
                        border: OutlineInputBorder(),
                      ),
                      items: sections.map((String section) {
                        return DropdownMenuItem<String>(
                          value: section,
                          child: Text(section),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _sectionValue = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Male', 'Female'].map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Separate ListView for available courses
                    SizedBox(
                      height: _availableCourses.length * 50,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: _availableCourses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final course = _availableCourses[index];

                          return CheckboxListTile(
                            title: Text(course.name),
                            subtitle: Text(
                                "Fee: ${course.courseFee.toStringAsFixed(2)} MMK"),
                            value: _selectedCourses.contains(course),
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  _selectedCourses.add(course);
                                  _newSelectedCourses.add(course);
                                } else {
                                  _selectedCourses.remove(course);
                                  _newSelectedCourses.remove(course);
                                }

                                _updateTotalFee();
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Total Fees: $_totalCourseFees MMK",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text("Discount: $discount%",
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: updateStudent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<Enrollment>>(
                      future: _enrollMethods
                          .getEnrollmentByStudent(widget.student.studentId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final enrollments = snapshot.data!;
                          return SizedBox(
                            height: snapshot.data!.length * 150,
                            child: ListView.builder(
                              itemCount: enrollments.length,
                              itemBuilder: (context, index) {
                                return EnrollmentCard(
                                    enrollment: enrollments[index]);
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('No enrollments found.'),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EnrollmentCard extends StatelessWidget {
  final Enrollment enrollment;

  const EnrollmentCard({super.key, required this.enrollment});

  @override
  Widget build(BuildContext context) {
    // Formatting the date and time
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(enrollment.enrolledTime);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              enrollment.courseName,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Cost: ${enrollment.totalCost.toStringAsFixed(2)} MMK',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Discount: ${enrollment.discountPercent.toString()}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Enrolled On:',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
