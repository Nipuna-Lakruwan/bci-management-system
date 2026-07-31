import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/course.dart';
import 'course_repository.dart';

class LocalCourseRepository implements CourseRepository {
  static const String _storageKey = 'bci_courses_data';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<Course>> getCourses() async {
    final prefs = await _getPrefs();
    final String? data = prefs.getString(_storageKey);
    
    if (data == null || data.isEmpty) {
      // Default sample data
      return [
        const Course(id: 'SE101', name: 'Introduction to Programming', credits: 4, lecturer: 'Dr. Amal Jayasinghe'),
        const Course(id: 'SE102', name: 'Database Systems', credits: 3, lecturer: 'Mr. Nimal Fernando'),
        const Course(id: 'MATH201', name: 'Discrete Mathematics', credits: 3, lecturer: 'Mrs. Sarah Perera'),
      ];
    }

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }

  Future<void> _saveAll(List<Course> courses) async {
    final prefs = await _getPrefs();
    final String data = jsonEncode(courses.map((c) => c.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }

  @override
  Future<Course?> getCourseById(String id) async {
    final courses = await getCourses();
    try {
      return courses.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addCourse(Course course) async {
    final courses = await getCourses();
    courses.add(course);
    await _saveAll(courses);
  }

  @override
  Future<void> updateCourse(Course course) async {
    final courses = await getCourses();
    final index = courses.indexWhere((c) => c.id == course.id);
    if (index != -1) {
      courses[index] = course;
      await _saveAll(courses);
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    final courses = await getCourses();
    courses.removeWhere((c) => c.id == id);
    await _saveAll(courses);
  }
}
