import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/models/student.dart';
import 'package:p2crudwithapi/bloc/student_bloc.dart';
import 'package:p2crudwithapi/bloc/student_event.dart';
import 'package:p2crudwithapi/bloc/student_state.dart';
import 'package:p2crudwithapi/widgets/student_card.dart';
import 'package:p2crudwithapi/widgets/dialogue.dart';
import 'add_student.dart';
import 'edit_student.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;
  final List<String> _yearOptions = [
    'First Year',
    'Second Year',
    'Third Year',
    'Fourth Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt_outlined,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is StudentLoaded) {
            return ListView.builder(
              itemCount: state.studentmodel.length,
              itemBuilder: (context, index) {
                final student = state.studentmodel[index];
                return StudentCard(
                  student: student,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditStudentScreen(student: student),
                      ),
                    );
                  },
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                          studentId: student.id!,
                          onConfirm: () {
                            context.read<StudentBloc>().add(DeleteStudent(student.id!));
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (state is StudentError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
