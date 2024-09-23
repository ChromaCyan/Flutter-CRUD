import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/models/student.dart';
import 'package:p2crudwithapi/bloc/student_bloc.dart';
import 'package:p2crudwithapi/bloc/student_event.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final courseController = TextEditingController();
  String _selectedYear = 'First Year';
  bool _isEnrolled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              value: _selectedYear,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYear = newValue!;
                });
              },
              items: ['First Year', 'Second Year', 'Third Year', 'Fourth Year']
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
                    setState(() {
                      _isEnrolled = newValue;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final newStudent = Student(
                  id: '',
                  firstname: firstNameController.text,
                  lastname: lastNameController.text,
                  course: courseController.text,
                  year: _selectedYear,
                  enrolled: _isEnrolled,
                );
                context.read<StudentBloc>().add(CreateStudent(newStudent));
                Navigator.pop(context);
              },
              child: Text('Add Student'),
            ),
          ],
        ),
      ),
    );
  }
}
