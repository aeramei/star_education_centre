class Section {
  String id;
  String name;
  String sectionTeacher;

  // Constructor
  Section({
    required this.id,
    required this.name,
    required this.sectionTeacher,
  });

  // Static method to convert a Section object to Firestore document (Map<String, dynamic>)
  static Map<String, dynamic> toFirebaseDoc(Section section) {
    return {
      'id': section.id,
      'name': section.name,
      'sectionTeacher': section.sectionTeacher,
    };
  }

  // Static method to create a Section object from Firestore document
  static Section fromFirebaseDoc(Map<String, dynamic> doc) {
    return Section(
      id: doc['id'],
      name: doc['name'],
      sectionTeacher: doc['sectionTeacher'],
    );
  }
}
