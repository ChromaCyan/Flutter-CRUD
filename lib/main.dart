import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/bloc/student_bloc.dart';
import 'package:p2crudwithapi/bloc/student_event.dart';
import 'package:p2crudwithapi/bloc/student_state.dart';
import 'package:p2crudwithapi/services/api.dart';
import 'package:p2crudwithapi/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bogart CRUD Student List',
      home: BlocProvider(
        create: (context) => StudentBloc(Api())..add(FetchStudents()),
        child: HomeScreen(),
      ),
    );
  }
}
