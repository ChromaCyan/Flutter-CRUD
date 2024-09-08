class Student {
  final String? id; // Add this line
  final String? lastname;
  final String? firstname;
  final String? year;
  final String? course;
  final bool? enrolled;

  Student({
    required this.id, // Add this line
    required this.lastname,
    required this.firstname,
    required this.year,
    required this.course,
    required this.enrolled,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'], // Add this line
      lastname: json['lastname'],
      firstname: json['firstname'],
      year: json['year'],
      course: json['course'],
      enrolled: json['enrolled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastname': lastname,
      'firstname': firstname,
      'year': year,
      'course': course,
      'enrolled': enrolled,
    };
  }
}
