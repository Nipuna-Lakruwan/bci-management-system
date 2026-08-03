import '../model/course.dart';

abstract class CourseReader {
  Future<List<Course>> getCourses();
  Future<Course?> getCourseById(String id);
}

abstract class CourseMutator {
  Future<void> addCourse(Course course);
  Future<void> updateCourse(Course course);
  Future<void> deleteCourse(String id);
}

abstract class CourseRepository implements CourseReader, CourseMutator {}
