import 'package:flutter/foundation.dart';
import '../domain/employee_attendance.dart';
import '../domain/hr_repository.dart';
import '../domain/leave_request.dart';

class HrController extends ChangeNotifier {
  final HrRepository _repository;

  List<LeaveRequest> _leaveRequests = [];
  List<EmployeeAttendance> _currentAttendance = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _currentDate = "";

  HrController(this._repository) {
    loadLeaveRequests();
    final now = DateTime.now();
    loadAttendance("${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}");
  }

  List<LeaveRequest> get leaveRequests => _leaveRequests;
  List<EmployeeAttendance> get currentAttendance => _currentAttendance;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get currentDate => _currentDate;

  Future<void> loadLeaveRequests() async {
    _setLoading(true);
    try {
      _leaveRequests = await _repository.getLeaveRequests();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load leave requests: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateLeaveStatus(String id, String status) async {
    final index = _leaveRequests.indexWhere((r) => r.id == id);
    if (index != -1) {
      final updatedRequest = _leaveRequests[index].copyWith(status: status);
      await _repository.updateLeaveRequest(updatedRequest);
      _leaveRequests[index] = updatedRequest;
      notifyListeners();
    }
  }

  Future<void> loadAttendance(String date) async {
    _setLoading(true);
    _currentDate = date;
    try {
      _currentAttendance = await _repository.getAttendance(date);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load attendance: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleAttendance(String employeeId, bool isPresent) async {
    final attendance = EmployeeAttendance(employeeId: employeeId, date: _currentDate, isPresent: isPresent);
    await _repository.updateAttendance(attendance);
    
    final index = _currentAttendance.indexWhere((a) => a.employeeId == employeeId);
    if (index != -1) {
      _currentAttendance[index] = attendance;
    } else {
      _currentAttendance.add(attendance);
    }
    notifyListeners();
  }

  bool isEmployeePresent(String employeeId) {
    final record = _currentAttendance.firstWhere(
      (a) => a.employeeId == employeeId,
      orElse: () => EmployeeAttendance(employeeId: employeeId, date: _currentDate, isPresent: false),
    );
    return record.isPresent;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
