import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';
import '../models/employee.dart';

class StorageService {
  static const String _studentsKey = 'students_data';
  static const String _employeesKey = 'employees_data';

  static Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    // Load Students
    final String? studentsJson = prefs.getString(_studentsKey);
    if (studentsJson != null) {
      final List<dynamic> decodedList = json.decode(studentsJson);
      mockStudents = decodedList.map((e) => Student.fromJson(e)).toList();
    }

    // Load Employees
    final String? employeesJson = prefs.getString(_employeesKey);
    if (employeesJson != null) {
      final List<dynamic> decodedList = json.decode(employeesJson);
      mockEmployees = decodedList.map((e) => Employee.fromJson(e)).toList();
    }
  }

  static Future<void> saveStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(mockStudents.map((e) => e.toJson()).toList());
    await prefs.setString(_studentsKey, encodedList);
  }

  static Future<void> saveEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = json.encode(mockEmployees.map((e) => e.toJson()).toList());
    await prefs.setString(_employeesKey, encodedList);
  }
}
