import '../model/course.dart';
import '../repository/course_repository.dart';

/// Service class to coordinate the Course business logic (SRP)
class CourseService {
  CourseService(this._repository);
  
  final CourseRepository _repository;

  Future<List<Course>> getAllCourses() async {
    return await _repository.getCourses();
  }

  Future<void> addCourse(Course course) async {
    await _repository.addCourse(course);
  }

  Future<void> updateCourse(Course course) async {
    await _repository.updateCourse(course);
  }

  Future<void> removeCourse(String id) async {
    await _repository.deleteCourse(id);
  }
}
