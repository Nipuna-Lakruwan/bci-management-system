import '../model/student.dart';

abstract class StudentReader {
  Future<List<Student>> getStudents();
  Future<Student?> getStudentById(String id);
}

abstract class StudentMutator {
  Future<void> addStudent(Student student);
  Future<void> updateStudent(Student student);
  Future<void> deleteStudent(String id);
}

abstract class StudentRepository implements StudentReader, StudentMutator {}
