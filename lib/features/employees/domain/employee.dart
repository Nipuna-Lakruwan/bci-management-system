import 'package:flutter/foundation.dart';

@immutable
class Employee {
  final String id;
  final String name;
  final String email;
  final String department;
  final String designation;
  final double basicSalary;
  final double allowances;
  final double overtime;
  final double deductions;
  final double tax;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.designation,
    required this.basicSalary,
    required this.allowances,
    required this.overtime,
    required this.deductions,
    required this.tax,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? department,
    String? designation,
    double? basicSalary,
    double? allowances,
    double? overtime,
    double? deductions,
    double? tax,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      basicSalary: basicSalary ?? this.basicSalary,
      allowances: allowances ?? this.allowances,
      overtime: overtime ?? this.overtime,
      deductions: deductions ?? this.deductions,
      tax: tax ?? this.tax,
    );
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'] ?? 'staff@bci.lk',
      department: json['department'],
      designation: json['designation'],
      basicSalary: (json['basicSalary'] as num).toDouble(),
      allowances: (json['allowances'] as num).toDouble(),
      overtime: (json['overtime'] as num).toDouble(),
      deductions: (json['deductions'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
      'designation': designation,
      'basicSalary': basicSalary,
      'allowances': allowances,
      'overtime': overtime,
      'deductions': deductions,
      'tax': tax,
    };
  }

  double get grossSalary => basicSalary + allowances + overtime;
  double get totalDeductions => deductions + tax;
  double get netSalary => grossSalary - totalDeductions;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.department == department &&
        other.designation == designation;
  }

  @override
  int get hashCode => Object.hash(id, name, email, department, designation);
}
