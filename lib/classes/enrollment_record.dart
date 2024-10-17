import 'package:firebase/abstract/record.dart';
import 'package:firebase/classes/course.dart';

class EnrollmentRecord implements RecordData {
  @override
  String id;
  @override
  DateTime recordTime;

  double discountPercent;
  double finalPrice;
  Course course;

  EnrollmentRecord({
    required this.id,
    required this.recordTime,
    required this.course,
    this.discountPercent = 0.0,
  }) : finalPrice = 0.0 {
    _calculateDiscountAndFinalPrice();
  }

  // Method to calculate discount and final price based on course fees
  void _calculateDiscountAndFinalPrice() {
    finalPrice = course.fees - (course.fees * (discountPercent / 100));
  }

  // Static method to convert EnrollmentRecord object to Firestore document (Map<String, dynamic>)
  static Map<String, dynamic> toFirebaseDoc(EnrollmentRecord enrollmentRecord) {
    return {
      'id': enrollmentRecord.id,
      'enrolledDate': enrollmentRecord.recordTime.toIso8601String(),
      'discountPercent': enrollmentRecord.discountPercent,
      'finalPrice': enrollmentRecord.finalPrice,
      'course': Course.toFirebaseDoc(enrollmentRecord.course),
    };
  }

  // Static method to create an EnrollmentRecord object from Firestore document
  static EnrollmentRecord fromFirebaseDoc(Map<String, dynamic> doc) {
    Course course = Course.fromFirebaseDoc(doc['course']);
    return EnrollmentRecord(
      id: doc['id'],
      recordTime: DateTime.parse(doc['enrolledDate']),
      course: course,
      discountPercent: doc['discountPercent'],
    );
  }

  static EnrollmentRecordFactory(
      EnrollmentRecord enrollmentRecord, int NumberOfCourse) {
    switch (NumberOfCourse) {
      case 0:
        return EnrollmentRecord(
            id: enrollmentRecord.id,
            recordTime: enrollmentRecord.recordTime,
            course: enrollmentRecord.course);
      case 1:
        return BasicEnrollmentRecord(
            id: enrollmentRecord.id,
            recordTime: enrollmentRecord.recordTime,
            course: enrollmentRecord.course);
      case 2:
        return StandardEnrollmentRecord(
            id: enrollmentRecord.id,
            recordTime: enrollmentRecord.recordTime,
            course: enrollmentRecord.course);
      default:
        return PremiumEnrollmentRecord(
            id: enrollmentRecord.id,
            recordTime: enrollmentRecord.recordTime,
            course: enrollmentRecord.course);
    }
  }
}

// Basic Enrollment (No discount)
class BasicEnrollmentRecord extends EnrollmentRecord {
  BasicEnrollmentRecord({
    required super.id,
    required super.recordTime,
    required super.course,
  }) : super(discountPercent: 5.0);

  @override
  void _calculateDiscountAndFinalPrice() {
    finalPrice = course.fees - (course.fees * (discountPercent / 100));
  }
}

// Standard Enrollment (10% discount)
class StandardEnrollmentRecord extends EnrollmentRecord {
  StandardEnrollmentRecord({
    required super.id,
    required super.recordTime,
    required super.course,
  }) : super(discountPercent: 10.0);

  @override
  void _calculateDiscountAndFinalPrice() {
    finalPrice = course.fees - (course.fees * (discountPercent / 100));
  }
}

// Premium Enrollment (20% discount)
class PremiumEnrollmentRecord extends EnrollmentRecord {
  PremiumEnrollmentRecord({
    required super.id,
    required super.recordTime,
    required super.course,
  }) : super(discountPercent: 20.0);

  @override
  void _calculateDiscountAndFinalPrice() {
    finalPrice = course.fees - (course.fees * (discountPercent / 100));
  }
}
