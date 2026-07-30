import '../model/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudents();
  Future<Student?> getStudentById(String id);
  Future<void> addStudent(Student student);
  Future<void> updateStudent(Student student);
  Future<void> deleteStudent(String id);
}
