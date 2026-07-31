class EmployeeAttendance {
  final String employeeId;
  final String date;
  bool isPresent;

  EmployeeAttendance({
    required this.employeeId,
    required this.date,
    this.isPresent = false,
  });
}

List<EmployeeAttendance> mockStaffAttendance = [];

EmployeeAttendance getOrCreateStaffAttendance(String employeeId, String date) {
  var record = mockStaffAttendance.where((r) => 
    r.employeeId == employeeId && 
    r.date == date
  ).firstOrNull;

  if (record == null) {
    record = EmployeeAttendance(employeeId: employeeId, date: date);
    mockStaffAttendance.add(record);
  }
  
  return record;
}
