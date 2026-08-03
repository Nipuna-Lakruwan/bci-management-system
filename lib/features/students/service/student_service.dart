import '../model/student.dart';
import '../repository/student_repository.dart';

/// Service class to coordinate the Student business logic (SRP)
class StudentService {
  StudentService(this._repository);
  
  final StudentRepository _repository;

  Future<List<Student>> getAllStudents() async {
    return await _repository.getStudents();
  }

  Future<void> registerStudent(Student student) async {
    // We could add extra business rules here like checking duplicates
    await _repository.addStudent(student);
  }

  Future<void> updateStudentDetails(Student student) async {
    await _repository.updateStudent(student);
  }

  Future<void> removeStudent(String id) async {
    await _repository.deleteStudent(id);
  }
}
