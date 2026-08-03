import 'leave_request.dart';
import 'employee_attendance.dart';

abstract class HrRepository {
  Future<List<LeaveRequest>> getLeaveRequests();
  Future<void> updateLeaveRequest(LeaveRequest request);
  Future<void> addLeaveRequest(LeaveRequest request);

  Future<List<EmployeeAttendance>> getAttendance(String date);
  Future<void> updateAttendance(EmployeeAttendance attendance);
}
