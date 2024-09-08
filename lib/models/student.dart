class Student {
  final String? lastname;
  final String? firstname;
  final String? year;
  final String? course;
  final bool? enrolled;

  Student({
  required this.lastname,
  required this.firstname,
  required this.year,
  required this.course,
  required this.enrolled,});

  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
      lastname: json['lastname'],
      firstname: json['firstname'],
      year: json['year'],
      course: json['course'],
      enrolled: json['enrolled'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'lastname': lastname,
      'firstname': firstname,
      'year': year,
      'course': course,
      'enrolled': enrolled,
    };
  }
}