import 'package:flutter/foundation.dart';

@immutable
class LeaveRequest {
  final String id;
  final String employeeName;
  final String date;
  final String type; // 'Annual' or 'Sick'
  final String status; // 'Pending', 'Approved', 'Rejected'

  const LeaveRequest({
    required this.id,
    required this.employeeName,
    required this.date,
    required this.type,
    this.status = 'Pending',
  });

  LeaveRequest copyWith({
    String? id,
    String? employeeName,
    String? date,
    String? type,
    String? status,
  }) {
    return LeaveRequest(
      id: id ?? this.id,
      employeeName: employeeName ?? this.employeeName,
      date: date ?? this.date,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      id: json['id'],
      employeeName: json['employeeName'],
      date: json['date'],
      type: json['type'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeName': employeeName,
      'date': date,
      'type': type,
      'status': status,
    };
  }
}
