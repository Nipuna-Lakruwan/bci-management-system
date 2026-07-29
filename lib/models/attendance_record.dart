class AttendanceRecord {
  final String moduleId;
  final String studentId;
  final String date;
  bool isPresent;

  AttendanceRecord({
    required this.moduleId,
    required this.studentId,
    required this.date,
    this.isPresent = false,
  });
}

// Global mock list for MVP
List<AttendanceRecord> mockAttendance = [];

// Helper to get or create an attendance record
AttendanceRecord getOrCreateAttendance(String moduleId, String studentId, String date) {
  var record = mockAttendance.where((r) => 
    r.moduleId == moduleId && 
    r.studentId == studentId && 
    r.date == date
  ).firstOrNull;

  if (record == null) {
    record = AttendanceRecord(moduleId: moduleId, studentId: studentId, date: date);
    mockAttendance.add(record);
  }
  
  return record;
}
