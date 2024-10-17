import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/classes/student.dart';

class StudentMethod {
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  // CREATE: Add a new Student to Firestore
  Future<void> createStudent(Student student) async {
    try {
      await studentsCollection
          .doc(student.id)
          .set(Student.toFirebaseDoc(student));
      print('Student added successfully');
    } catch (e) {
      print('Failed to add student: $e');
    }
  }

  // READ: Get a Student from Firestore by ID
  Future<Student?> getStudentById(String id) async {
    try {
      DocumentSnapshot doc = await studentsCollection.doc(id).get();
      if (doc.exists) {
        return Student.fromFirebaseDoc(doc.data() as Map<String, dynamic>);
      } else {
        print('No student found with the given ID');
        return null;
      }
    } catch (e) {
      print('Failed to fetch student: $e');
      return null;
    }
  }

  // READ: Get all Students from Firestore
  Future<List<Student>> getAllStudents() async {
    try {
      QuerySnapshot querySnapshot = await studentsCollection.get();
      return querySnapshot.docs
          .map((doc) =>
              Student.fromFirebaseDoc(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to fetch students: $e');
      return [];
    }
  }

  // UPDATE: Update a Student's data in Firestore
  Future<void> updateStudent(Student student) async {
    try {
      await studentsCollection
          .doc(student.id)
          .update(Student.toFirebaseDoc(student));
      print('Student updated successfully');
    } catch (e) {
      print('Failed to update student: $e');
    }
  }

  // DELETE: Delete a Student from Firestore by ID
  Future<void> deleteStudent(String id) async {
    try {
      await studentsCollection.doc(id).delete();
      print('Student deleted successfully');
    } catch (e) {
      print('Failed to delete student: $e');
    }
  }
}
