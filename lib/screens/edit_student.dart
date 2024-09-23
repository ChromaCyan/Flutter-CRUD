import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/models/student.dart';
import 'package:p2crudwithapi/bloc/student_bloc.dart';
import 'package:p2crudwithapi/bloc/student_event.dart';

class EditStudentScreen extends StatelessWidget {
  final Student student;

  EditStudentScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentBloc>();

    final firstNameController = TextEditingController(text: student.firstname);
    final lastNameController = TextEditingController(text: student.lastname);
    final courseController = TextEditingController(text: student.course);
    String _selectedYear = student.year ?? 'First Year';
    bool _isEnrolled = student.enrolled ?? false;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Student')),
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
                _selectedYear = newValue!;
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
                    _isEnrolled = newValue;
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final updatedStudent = Student(
                  id: student.id,
                  firstname: firstNameController.text,
                  lastname: lastNameController.text,
                  course: courseController.text,
                  year: _selectedYear,
                  enrolled: _isEnrolled,
                );
                bloc.add(UpdateStudent(student.id!, updatedStudent));
                Navigator.pop(context);
              },
              child: Text('Update Student'),
            ),
          ],
        ),
      ),
    );
  }
}
