import '../model/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<Course?> getCourseById(String id);
  Future<void> addCourse(Course course);
  Future<void> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}
