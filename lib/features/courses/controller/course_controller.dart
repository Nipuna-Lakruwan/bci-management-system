import 'package:flutter/material.dart';
import '../model/course.dart';
import '../repository/course_repository.dart';

class CourseController extends ChangeNotifier {
  final CourseRepository _repository;
  
  CourseController(this._repository) {
    loadCourses();
  }

  List<Course> _courses = [];
  bool _isLoading = false;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;

  Future<void> loadCourses() async {
    _setLoading(true);
    _courses = await _repository.getCourses();
    _setLoading(false);
  }

  Future<void> addCourse(Course course) async {
    _setLoading(true);
    await _repository.addCourse(course);
    await loadCourses();
  }

  Future<void> updateCourse(Course course) async {
    _setLoading(true);
    await _repository.updateCourse(course);
    await loadCourses();
  }

  Future<void> deleteCourse(String id) async {
    _setLoading(true);
    await _repository.deleteCourse(id);
    await loadCourses();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
