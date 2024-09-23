import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/services/api.dart';
import 'student_event.dart';
import 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final ApiCall _studentapi;

  StudentBloc(this._studentapi) : super(StudentLoading()) {
    // Handle fetching all students
    on<FetchStudents>((event, emit) async {
      try {
        emit(StudentLoading());
        final studentmodel = await _studentapi.getStudents();
        emit(StudentLoaded(studentmodel));
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });

    // Handle creating a new student
    on<CreateStudent>((event, emit) async {
      try {
        await _studentapi.addStudent(event.studentmodel);
        // Simply call add without needing to use its result
        add(FetchStudents());
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });

    // Handle updating an existing student
    on<UpdateStudent>((event, emit) async {
      try {
        await _studentapi.updateStudent(event.id, event.studentmodel);
        add(FetchStudents()); // Refresh the student list
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });

    // Handle deleting a student
    on<DeleteStudent>((event, emit) async {
      try {
        await _studentapi.deleteStudent(event.id);
        add(FetchStudents()); // Refresh the student list
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });
  }
}
