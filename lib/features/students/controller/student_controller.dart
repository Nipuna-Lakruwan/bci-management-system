import 'package:flutter/material.dart';
import '../model/student.dart';
import '../service/student_service.dart';

class StudentController extends ChangeNotifier {
  final StudentService _service;
  
  StudentController(this._service) {
    loadStudents();
  }

  List<Student> _students = [];
  List<Student> _filteredStudents = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Student> get students => _filteredStudents;
  bool get isLoading => _isLoading;

  Future<void> loadStudents() async {
    _setLoading(true);
    _students = await _service.getAllStudents();
    _applyFilter();
    _setLoading(false);
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilter();
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredStudents = List.from(_students);
    } else {
      _filteredStudents = _students.where((student) {
        return student.name.toLowerCase().contains(_searchQuery) ||
               student.id.toLowerCase().contains(_searchQuery) ||
               student.program.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }

  Future<void> addStudent(Student student) async {
    _setLoading(true);
    await _service.registerStudent(student);
    await loadStudents();
  }

  Future<void> updateStudent(Student student) async {
    _setLoading(true);
    await _service.updateStudentDetails(student);
    await loadStudents();
  }

  Future<void> deleteStudent(String id) async {
    _setLoading(true);
    await _service.removeStudent(id);
    await loadStudents();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
