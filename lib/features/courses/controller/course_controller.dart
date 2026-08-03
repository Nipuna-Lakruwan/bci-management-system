import 'package:flutter/material.dart';
import '../model/course.dart';
import '../service/course_service.dart';

class CourseController extends ChangeNotifier {
  final CourseService _service;
  
  CourseController(this._service) {
    loadCourses();
  }

  List<Course> _courses = [];
  bool _isLoading = false;

  List<Course> get courses => _courses;
  bool get isLoading => _isLoading;

  Future<void> loadCourses() async {
    _setLoading(true);
    _courses = await _service.getAllCourses();
    _setLoading(false);
  }

  Future<void> addCourse(Course course) async {
    _setLoading(true);
    await _service.addCourse(course);
    await loadCourses();
  }

  Future<void> updateCourse(Course course) async {
    _setLoading(true);
    await _service.updateCourse(course);
    await loadCourses();
  }

  Future<void> deleteCourse(String id) async {
    _setLoading(true);
    await _service.removeCourse(id);
    await loadCourses();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
