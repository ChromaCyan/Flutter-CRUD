import 'package:equatable/equatable.dart';
import 'package:p2crudwithapi/models/student.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object?> get props => [];
}

class FetchStudents extends StudentEvent {}

class CreateStudent extends StudentEvent {
  final Student studentmodel;

  const CreateStudent(this.studentmodel);

  @override
  List<Object?> get props => [studentmodel];
}

class DeleteStudent extends StudentEvent {
  final String id;
  const DeleteStudent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateStudent extends StudentEvent {
  final String id;
  final Student studentmodel;
  const UpdateStudent(this.id, this.studentmodel);

  @override
  List<Object?> get props => [id, studentmodel];
}
