import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/models/student.dart';
import 'package:p2crudwithapi/bloc/student_bloc.dart';
import 'package:p2crudwithapi/bloc/student_event.dart';
import 'package:p2crudwithapi/bloc/student_state.dart';

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
        title: Text('Students'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.person_add_alt_1,
              color: Colors.lightGreen,
            ),
            onPressed: () => _showStudentDialog(context, isUpdate: false),
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
                return ListTile(
                  title: Text('${student.firstname} ${student.lastname}'),
                  subtitle: Text('Course: ${student.course}, Year: ${student.year}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        onPressed: () => _showStudentDialog(context,
                            student: student, isUpdate: true),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          BlocProvider.of<StudentBloc>(context)
                              .add(DeleteStudent(student.id!)); // Ensure student has an id
                        },
                      ),
                    ],
                  ),
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

  void _showStudentDialog(BuildContext context,
      {Student? student, required bool isUpdate}) {
    final firstNameController =
    TextEditingController(text: student?.firstname ?? '');
    final lastNameController =
    TextEditingController(text: student?.lastname ?? '');
    final courseController = TextEditingController(text: student?.course ?? '');

    _isEnrolled = student?.enrolled ?? false;
    String _selectedYearInDialog =
        student?.year ?? _yearOptions[1]; // Avoid empty initial value

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext dialogContext, StateSetter setDialogState) {
            return AlertDialog(
              title: Text(isUpdate ? 'Update Student' : 'Create Student'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: courseController,
                      decoration: InputDecoration(labelText: 'Course'),
                    ),
                    DropdownButton<String>(
                      value: _yearOptions.contains(_selectedYearInDialog)
                          ? _selectedYearInDialog
                          : _yearOptions[0],
                      onChanged: (String? newValue) {
                        setDialogState(() {
                          _selectedYearInDialog = newValue!;
                        });
                      },
                      items: _yearOptions
                          .map<DropdownMenuItem<String>>((String year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Enrolled'),
                        Switch(
                          value: _isEnrolled,
                          onChanged: (bool newValue) {
                            setDialogState(() {
                              _isEnrolled = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final studentBloc = BlocProvider.of<StudentBloc>(context);
                    final newStudent = Student(
                      id: isUpdate ? student!.id : '', // Ensure the id is properly assigned
                      firstname: firstNameController.text,
                      lastname: lastNameController.text,
                      course: courseController.text,
                      year: _selectedYearInDialog,
                      enrolled: _isEnrolled,
                    );
                    if (isUpdate) {
                      studentBloc.add(UpdateStudent(newStudent.id!, newStudent));
                    } else {
                      studentBloc.add(CreateStudent(newStudent));
                    }
                    Navigator.pop(dialogContext);
                  },
                  child: Text(isUpdate ? 'Update' : 'Create'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
