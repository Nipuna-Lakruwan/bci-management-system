import 'package:flutter/material.dart';
import '../model/enrolment.dart';
import '../repository/enrolment_repository.dart';

class EnrolmentController extends ChangeNotifier {
  final EnrolmentRepository _repository;
  
  EnrolmentController(this._repository) {
    loadEnrolments();
  }

  List<Enrolment> _enrolments = [];
  bool _isLoading = false;

  List<Enrolment> get enrolments => _enrolments;
  bool get isLoading => _isLoading;

  Future<void> loadEnrolments() async {
    _setLoading(true);
    _enrolments = await _repository.getAllEnrolments();
    _setLoading(false);
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
