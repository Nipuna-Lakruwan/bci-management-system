import 'dart:convert';
import '../../../core/storage/storage_service.dart';
import '../domain/employee_attendance.dart';
import '../domain/hr_repository.dart';
import '../domain/leave_request.dart';

class HrRepositoryImpl implements HrRepository {
  final StorageService _storageService;
  static const String _leaveKey = 'leave_requests_data';
  static const String _attendanceKey = 'attendance_data';

  HrRepositoryImpl(this._storageService);

  @override
  Future<List<LeaveRequest>> getLeaveRequests() async {
    final String? data = await _storageService.getString(_leaveKey);
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => LeaveRequest.fromJson(json)).toList();
    }
    return _getMockLeaveRequests();
  }

  @override
  Future<void> updateLeaveRequest(LeaveRequest request) async {
    final requests = await getLeaveRequests();
    final index = requests.indexWhere((r) => r.id == request.id);
    if (index != -1) {
      requests[index] = request;
      await _saveLeaveRequests(requests);
    }
  }

  @override
  Future<void> addLeaveRequest(LeaveRequest request) async {
    final requests = await getLeaveRequests();
    requests.add(request);
    await _saveLeaveRequests(requests);
  }

  Future<void> _saveLeaveRequests(List<LeaveRequest> requests) async {
    final String data = json.encode(requests.map((r) => r.toJson()).toList());
    await _storageService.setString(_leaveKey, data);
  }

  @override
  Future<List<EmployeeAttendance>> getAttendance(String date) async {
    final String? data = await _storageService.getString(_attendanceKey);
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      final allAttendance = jsonList.map((json) => EmployeeAttendance.fromJson(json)).toList();
      return allAttendance.where((a) => a.date == date).toList();
    }
    return [];
  }

  @override
  Future<void> updateAttendance(EmployeeAttendance attendance) async {
    final String? data = await _storageService.getString(_attendanceKey);
    List<EmployeeAttendance> allAttendance = [];
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      allAttendance = jsonList.map((json) => EmployeeAttendance.fromJson(json)).toList();
    }

    final index = allAttendance.indexWhere((a) => a.employeeId == attendance.employeeId && a.date == attendance.date);
    if (index != -1) {
      allAttendance[index] = attendance;
    } else {
      allAttendance.add(attendance);
    }

    final String updatedData = json.encode(allAttendance.map((a) => a.toJson()).toList());
    await _storageService.setString(_attendanceKey, updatedData);
  }

  List<LeaveRequest> _getMockLeaveRequests() {
    return [
      const LeaveRequest(id: 'LR-001', employeeName: 'Dr. Amal Jayasinghe', date: '2023-11-15', type: 'Annual', status: 'Approved'),
      const LeaveRequest(id: 'LR-002', employeeName: 'Rashmi Perera', date: '2023-11-20', type: 'Sick', status: 'Pending'),
      const LeaveRequest(id: 'LR-003', employeeName: 'Kamal Fernando', date: '2023-11-25', type: 'Annual', status: 'Pending'),
    ];
  }
}
