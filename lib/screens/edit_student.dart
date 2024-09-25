import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2crudwithapi/models/student.dart';
import 'package:p2crudwithapi/bloc/student_bloc.dart';
import 'package:p2crudwithapi/bloc/student_event.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  EditStudentScreen({required this.student});

  @override
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController courseController;
  late String _selectedYear;
  late bool _isEnrolled;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.student.firstname);
    lastNameController = TextEditingController(text: widget.student.lastname);
    courseController = TextEditingController(text: widget.student.course);
    _selectedYear = widget.student.year ?? 'First Year';
    _isEnrolled = widget.student.enrolled ?? false;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentBloc>();

    return Scaffold(
      appBar: AppBar(title: Text('Edit Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Student Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              TextField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),

              TextField(
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),

              TextField(
                controller: courseController,
                decoration: InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedYear,
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
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
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enrolled', style: TextStyle(fontSize: 16)),
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
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  final updatedStudent = Student(
                    id: widget.student.id,
                    firstname: firstNameController.text,
                    lastname: lastNameController.text,
                    course: courseController.text,
                    year: _selectedYear,
                    enrolled: _isEnrolled,
                  );
                  bloc.add(UpdateStudent(widget.student.id!, updatedStudent));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Update Student', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
