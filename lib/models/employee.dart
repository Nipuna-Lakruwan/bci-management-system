class Employee {
  Employee({
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

  String id;
  String name;
  String email;
  String department;
  String designation;
  double basicSalary;
  double allowances;
  double overtime;
  double deductions;
  double tax;

  double get grossSalary => basicSalary + allowances + overtime;
  double get totalDeductions => deductions + tax;
  double get netSalary => grossSalary - totalDeductions;
}

// Global mock list for MVP
List<Employee> mockEmployees = [
  Employee(
    id: 'EMP-001',
    name: 'Dr. Amal Jayasinghe',
    email: 'amal.j@bci.lk',
    department: 'School of Computing',
    designation: 'Senior Lecturer',
    basicSalary: 185000,
    allowances: 35000,
    overtime: 12000,
    deductions: 8500,
    tax: 17500,
  ),
  Employee(
    id: 'EMP-002',
    name: 'Rashmi Perera',
    email: 'rashmi.p@bci.lk',
    department: 'Finance',
    designation: 'Finance Officer',
    basicSalary: 125000,
    allowances: 22000,
    overtime: 6500,
    deductions: 5000,
    tax: 9500,
  ),
  Employee(
    id: 'EMP-003',
    name: 'Kamal Fernando',
    email: 'kamal.f@bci.lk',
    department: 'Administration',
    designation: 'Management Assistant',
    basicSalary: 95000,
    allowances: 18000,
    overtime: 8000,
    deductions: 3500,
    tax: 4200,
  ),
];
