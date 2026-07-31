import '../model/enrolment.dart';

abstract class EnrolmentRepository {
  Future<List<Enrolment>> getAllEnrolments();
  Future<Enrolment?> getEnrolmentByStudentId(String studentId);
  Future<void> saveEnrolment(Enrolment enrolment);
  Future<void> deleteEnrolment(String studentId);
}
