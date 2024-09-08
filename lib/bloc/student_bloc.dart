import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/services/api.dart';
import 'package:provider/provider.dart';
import 'student_event.dart';
import 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState>{
  final ApiCall _studentapi;

  StudentBloc(this._studentapi) : super(StudentLoading()) {
    on<FetchStudents>((event, emit) async {
      try {
        emit(StudentLoading());
        final studentmodel = await _studentapi.getStudents();
        emit(StudentLoaded(studentmodel));
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });

    on<CreateStudent>((event, emit) async {
      try {
        await _studentapi.addStudent(event.studentmodel);
        add(FetchStudents());
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });

    on<UpdateStudent>((event, emit) async {
      try {
        await _studentapi.updateStudent(event.id, event.studentmodel);
        add(FetchStudents());
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });

    on<DeleteStudent>((event, emit) async {
      try {
        await _studentapi.deleteStudent(event.id);
        add(FetchStudents());
      } catch (e) {
        emit(StudentError(e.toString()));
      }
    });
  }
}