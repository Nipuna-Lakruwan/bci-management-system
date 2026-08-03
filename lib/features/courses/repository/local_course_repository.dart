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
    
    // If empty or we want to seed new data, initialize with the full BSc IT Module list
    if (data == null || data.isEmpty || data.length < 500) {
      final defaultCourses = [
        const Course(id: 'BSIT 11013', name: 'Introduction to Computer Systems', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 11024', name: 'Fundamentals of Programming', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 11033', name: 'Fundamentals of Web Design', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 11044', name: 'Mathematics for IT', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 11052', name: 'English for IT', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 12014', name: 'Computer Networks', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 12023', name: 'Operating Systems', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 12034', name: 'Database Management Systems', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 12044', name: 'System Analysis and Design', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 21013', name: 'Software Engineering Methods', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 21023', name: 'Object Oriented Programming', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 21033', name: 'Data Structures and Algorithms', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 21044', name: 'Computer Architecture and Organization', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 21054', name: 'Web Programming', credits: 4, lecturer: 'TBD'),
        const Course(id: 'BSIT 21062', name: 'Introduction to Probability and Statistics', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 22013', name: 'Visual Application Programming', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 22023', name: 'Multimedia Development', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 22032', name: 'IT Project Management', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 22043', name: 'Cyber Security Fundamentals', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 22052', name: 'Research Methodology', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 22063', name: 'Group Software Project', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 31012', name: 'IT Quality Assurance', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 31023', name: 'Big Data Analytics', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 31032', name: 'Introduction to Artificial Intelligence', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 31043', name: 'Professional Practice and Ethics', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 31053', name: 'Web Services', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 31062', name: 'Statistical Distributions', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 31073', name: 'Human Computer Interaction', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 32006', name: 'Industrial Training (GPA)', credits: 6, lecturer: 'TBD'),
        const Course(id: 'BSIT 41013', name: 'Distributed Systems and Cloud Computing', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 41023', name: 'Advanced Database Systems', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 41033', name: 'Applied Machine Learning', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 41043', name: 'Data Mining & Data Warehousing', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 41053', name: 'Information Retrieval and Web Analytics', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 41063', name: 'Mobile Application Development', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 43078', name: 'Research Project', credits: 8, lecturer: 'TBD'),
        const Course(id: 'BSIT 42013', name: 'Wireless Communication and Networks', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 42023', name: 'Introduction to IoT', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 42033', name: 'Enterprise Application Development', credits: 3, lecturer: 'TBD'),
        const Course(id: 'BSIT 42042', name: 'Data Visualization', credits: 2, lecturer: 'TBD'),
        const Course(id: 'BSIT 42053', name: 'Cyber Attacks and Detection', credits: 3, lecturer: 'TBD'),
      ];
      await prefs.setString(_storageKey, jsonEncode(defaultCourses.map((c) => c.toJson()).toList()));
      return defaultCourses;
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
    } else {
      throw Exception('Course with id ${course.id} not found.');
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    final courses = await getCourses();
    final initialLength = courses.length;
    courses.removeWhere((c) => c.id == id);
    if (courses.length == initialLength) {
      throw Exception('Course with id $id not found.');
    }
    await _saveAll(courses);
  }
}
