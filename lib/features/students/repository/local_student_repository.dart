import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/student.dart';
import 'student_repository.dart';

class LocalStudentRepository implements StudentRepository {
  static const String _storageKey = 'bci_students_data';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<Student>> getStudents() async {
    final prefs = await _getPrefs();
    final String? data = prefs.getString(_storageKey);
    
    if (data == null || data.isEmpty) {
      // Return some initial data if empty
      return [
        const Student(id: 'STU001', name: 'Nipuna Lakruwan', email: 'nipuna@bci.edu', program: 'BSc Computer Science', intake: '2024', status: 'Active'),
        const Student(id: 'STU002', name: 'Sarah Perera', email: 'sarah@bci.edu', program: 'BBA Business Admin', intake: '2024', status: 'Active'),
      ];
    }

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => Student.fromJson(json)).toList();
  }

  Future<void> _saveAll(List<Student> students) async {
    final prefs = await _getPrefs();
    final String data = jsonEncode(students.map((s) => s.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }

  @override
  Future<Student?> getStudentById(String id) async {
    final students = await getStudents();
    try {
      return students.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addStudent(Student student) async {
    final students = await getStudents();
    students.add(student);
    await _saveAll(students);
  }

  @override
  Future<void> updateStudent(Student student) async {
    final students = await getStudents();
    final index = students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      students[index] = student;
      await _saveAll(students);
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    final students = await getStudents();
    students.removeWhere((s) => s.id == id);
    await _saveAll(students);
  }
}
