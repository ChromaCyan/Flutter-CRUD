class Student {
  final String id;
  final String lastname;
  final String firstname;
  final String year;
  final String course;
  final bool enrolled;

  Student({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.year,
    required this.course,
    required this.enrolled,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'],
      lastname: json['lastname'],
      firstname: json['firstname'],
      year: json['year'],
      course: json['course'],
      enrolled: json['enrolled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'lastname': lastname,
      'firstname': firstname,
      'year': year,
      'course': course,
      'enrolled': enrolled,
    };
  }
}
