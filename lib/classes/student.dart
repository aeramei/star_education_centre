import 'package:firebase/classes/enrollment_record.dart';

class Student {
  String id;
  String name;
  DateTime DOB;
  String gender;
  String email;
  String phone;
  String fatherName;
  String sectionId;
  List<EnrollmentRecord> enrollmentRecords;

  // Constructor
  Student({
    required this.id,
    required this.name,
    required this.DOB,
    required this.gender,
    required this.email,
    this.phone = '',
    this.fatherName = '',
    this.sectionId = '',
    this.enrollmentRecords = const [],
  });

  // Static method to convert a Student object to Firestore document (Map<String, dynamic>)
  static Map<String, dynamic> toFirebaseDoc(Student student) {
    return {
      'id': student.id,
      'name': student.name,
      'DOB': student.DOB.toIso8601String(),
      'gender': student.gender,
      'email': student.email,
      'phone': student.phone,
      'fatherName': student.fatherName,
      'sectionId': student.sectionId,
      'enrollmentRecords': student.enrollmentRecords
          .map((record) => EnrollmentRecord.toFirebaseDoc(record))
          .toList(), // Convert each enrollment record to Firebase doc
    };
  }

  // Static method to create a Student object from Firestore document
  static Student fromFirebaseDoc(Map<String, dynamic> doc) {
    return Student(
      id: doc['id'],
      name: doc['name'],
      DOB: DateTime.parse(doc['DOB']),
      gender: doc['gender'],
      email: doc['email'],
      phone: doc['phone'] ?? '',
      fatherName: doc['fatherName'] ?? '',
      sectionId: doc['sectionId'] ?? '',
      enrollmentRecords: (doc['enrollmentRecords'] as List)
          .map((record) => EnrollmentRecord.fromFirebaseDoc(record))
          .toList(), // Convert back enrollment records
    );
  }
}
