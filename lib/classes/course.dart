class Course {
  String id;
  String name;
  String about;
  String teacher;
  double fees;
  double learningHour;

  // Constructor
  Course({
    required this.id,
    required this.name,
    required this.about,
    required this.fees,
    required this.teacher,
    required this.learningHour,
  });

  // Static method to convert a Course object to Firestore document (Map<String, dynamic>)
  static Map<String, dynamic> toFirebaseDoc(Course course) {
    return {
      'id': course.id,
      'name': course.name,
      'about': course.about,
      'fees': course.fees,
      'teacher': course.teacher,
      'learningHour': course.learningHour,
    };
  }

  // Static method to create a Course object from Firestore document
  static Course fromFirebaseDoc(Map<String, dynamic> doc) {
    return Course(
      id: doc['id'],
      name: doc['name'],
      about: doc['about'],
      fees: doc['fees'],
      teacher: doc['teacher'],
      learningHour: (doc['learningHour'] as num).toDouble(),
    );
  }
}
