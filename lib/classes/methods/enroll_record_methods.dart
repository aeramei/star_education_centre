import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/classes/enrollment_record.dart';

class EnrollRecordMethod {
  final CollectionReference enrollmentsCollection =
  FirebaseFirestore.instance.collection('enrollmentRecords');

  // CREATE: Add a new EnrollmentRecord to Firestore
  Future<bool> createEnrollmentRecord(EnrollmentRecord enrollmentRecord) async {
    bool success = false;
    try {
      await enrollmentsCollection
          .doc(enrollmentRecord.id)
          .set(EnrollmentRecord.toFirebaseDoc(enrollmentRecord));
      print('EnrollmentRecord added successfully');
      success = true;
    } catch (e) {
      print('Failed to add EnrollmentRecord: $e');
    }
    return success;
  }

  // READ: Get an EnrollmentRecord from Firestore by ID
  Future<EnrollmentRecord?> getEnrollmentRecordById(String id) async {
    try {
      DocumentSnapshot doc = await enrollmentsCollection.doc(id).get();
      if (doc.exists) {
        return EnrollmentRecord.fromFirebaseDoc(doc.data() as Map<String, dynamic>);
      } else {
        print('No EnrollmentRecord found with the given ID');
        return null;
      }
    } catch (e) {
      print('Failed to fetch EnrollmentRecord: $e');
      return null;
    }
  }

  // READ: Get all EnrollmentRecords from Firestore
  Future<List<EnrollmentRecord>> getAllEnrollmentRecords() async {
    try {
      QuerySnapshot querySnapshot = await enrollmentsCollection.get();
      return querySnapshot.docs
          .map((doc) => EnrollmentRecord.fromFirebaseDoc(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to fetch EnrollmentRecords: $e');
      return [];
    }
  }

  // UPDATE: Update an existing EnrollmentRecord in Firestore
  Future<void> updateEnrollmentRecord(EnrollmentRecord enrollmentRecord) async {
    try {
      await enrollmentsCollection
          .doc(enrollmentRecord.id)
          .update(EnrollmentRecord.toFirebaseDoc(enrollmentRecord));
      print('EnrollmentRecord updated successfully');
    } catch (e) {
      print('Failed to update EnrollmentRecord: $e');
    }
  }

  // DELETE: Delete an EnrollmentRecord from Firestore by ID
  Future<void> deleteEnrollmentRecord(String id) async {
    try {
      await enrollmentsCollection.doc(id).delete();
      print('EnrollmentRecord deleted successfully');
    } catch (e) {
      print('Failed to delete EnrollmentRecord: $e');
    }
  }
}
