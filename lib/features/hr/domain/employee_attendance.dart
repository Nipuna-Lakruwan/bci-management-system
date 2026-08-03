import 'package:flutter/foundation.dart';

@immutable
class EmployeeAttendance {
  final String employeeId;
  final String date;
  final bool isPresent;

  const EmployeeAttendance({
    required this.employeeId,
    required this.date,
    this.isPresent = false,
  });

  EmployeeAttendance copyWith({
    String? employeeId,
    String? date,
    bool? isPresent,
  }) {
    return EmployeeAttendance(
      employeeId: employeeId ?? this.employeeId,
      date: date ?? this.date,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  factory EmployeeAttendance.fromJson(Map<String, dynamic> json) {
    return EmployeeAttendance(
      employeeId: json['employeeId'],
      date: json['date'],
      isPresent: json['isPresent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'date': date,
      'isPresent': isPresent,
    };
  }
}
