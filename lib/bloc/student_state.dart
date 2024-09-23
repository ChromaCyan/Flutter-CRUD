import 'package:equatable/equatable.dart';
import 'package:p2crudwithapi/models/student.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final List<Student> studentmodel;

  const StudentLoaded(this.studentmodel);

  @override
  List<Object?> get props => studentmodel;
}

class StudentDetailLoaded extends StudentState {
  final Student student;

  const StudentDetailLoaded(this.student);

  @override
  List<Object?> get props => [student];
}

class StudentError extends StudentState {
  final String message;

  const StudentError(this.message);

  @override
  List<Object?> get props => [message];
}
