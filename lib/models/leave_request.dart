class LeaveRequest {
  final String id;
  final String employeeName;
  final String date;
  final String type; // 'Annual' or 'Sick'
  String status; // 'Pending', 'Approved', 'Rejected'

  LeaveRequest({
    required this.id,
    required this.employeeName,
    required this.date,
    required this.type,
    this.status = 'Pending',
  });
}

// Global mock list for MVP
List<LeaveRequest> mockLeaveRequests = [
  LeaveRequest(id: 'LR-001', employeeName: 'Dr. Amal Jayasinghe', date: '2023-11-15', type: 'Annual', status: 'Approved'),
  LeaveRequest(id: 'LR-002', employeeName: 'Rashmi Perera', date: '2023-11-20', type: 'Sick', status: 'Pending'),
  LeaveRequest(id: 'LR-003', employeeName: 'Kamal Fernando', date: '2023-11-25', type: 'Annual', status: 'Pending'),
];
