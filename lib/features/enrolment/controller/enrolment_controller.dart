import 'package:flutter/material.dart';
import '../model/enrolment.dart';
import '../repository/enrolment_repository.dart';
import '../../students/repository/student_repository.dart';
import '../../students/model/student.dart';
import '../../courses/repository/course_repository.dart';
import '../../courses/model/course.dart';

class EnrolmentController extends ChangeNotifier {
  final EnrolmentRepository _repository;
  final StudentReader _studentReader;
  final CourseReader _courseReader;
  
  EnrolmentController(this._repository, this._studentReader, this._courseReader) {
    loadData();
  }

  List<Enrolment> _enrolments = [];
  List<Student> _students = [];
  List<Course> _courses = [];
  bool _isLoading = false;

  List<Enrolment> get enrolments => _enrolments;
  List<Student> get students => _students;
  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _setLoading(true);
    _enrolments = await _repository.getAllEnrolments();
    _students = await _studentReader.getStudents();
    _courses = await _courseReader.getCourses();
    _setLoading(false);
  }
  
  Future<void> loadEnrolments() async {
    _enrolments = await _repository.getAllEnrolments();
    notifyListeners();
  }

  Enrolment? getEnrolmentForStudent(String studentId) {
    try {
      return _enrolments.firstWhere((e) => e.studentId == studentId);
    } catch (_) {
      return null;
    }
  }

  List<String> getEnrolledCourseIds(String studentId) {
    return getEnrolmentForStudent(studentId)?.courseIds ?? [];
  }

  Future<void> updateEnrolment(String studentId, List<String> courseIds) async {
    _setLoading(true);
    final enrolment = Enrolment(studentId: studentId, courseIds: courseIds);
    await _repository.saveEnrolment(enrolment);
    await loadEnrolments();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
