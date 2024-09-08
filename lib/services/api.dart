import 'dart:convert';
import '../models/student.dart';
import 'package:http/http.dart' as http;

abstract class ApiCall {
  Future<List<Student>> getStudents(); // Updated method name
  Future<void> addStudent(Student studentmodel);
  Future<void> updateStudent(String id, Student studentmodel);
  Future<void> deleteStudent(String id);
}

class Api implements ApiCall { // Implementing ApiCall
  static const baseURL = "http://192.168.137.1:3000";

  // Add Student
  @override
  Future<void> addStudent(Student studentmodel) async {
    try {
      final res = await http.post(
        Uri.parse("$baseURL/students"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(studentmodel.toJson()),
      );

      if (res.statusCode == 200) {
        print("Student Added Successfully");
      } else {
        print("Failed to Add Student: ${res.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Edit Student
  @override
  Future<void> updateStudent(String id, Student studentmodel) async {
    try {
      final res = await http.put(
        Uri.parse("$baseURL/students/$id"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(studentmodel.toJson()),
      );

      if (res.statusCode == 200) {
        print("Student Updated Successfully");
      } else {
        print("Failed to Update Student: ${res.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Delete Student
  @override
  Future<void> deleteStudent(String id) async {
    try {
      final res = await http.delete(
        Uri.parse("$baseURL/students/$id"),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        print("Student Deleted Successfully");
      } else {
        print("Failed to Delete Student: ${res.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Fetch Students
  @override
  Future<List<Student>> getStudents() async { // Updated method name
    try {
      final res = await http.get(Uri.parse("$baseURL/students"));

      if (res.statusCode == 200) {
        final List data = jsonDecode(res.body);
        return data.map((json) => Student.fromJson(json)).toList();
      } else {
        print("Failed to fetch Students: ${res.body}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
