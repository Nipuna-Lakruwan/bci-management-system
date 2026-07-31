class Student {
  final String id;
  final String name;
  final String email;
  final String program;
  final String intake;
  final String status;

  const Student({
    required this.id,
    required this.name,
    required this.email,
    required this.program,
    required this.intake,
    required this.status,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      program: json['program'],
      intake: json['intake'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'program': program,
      'intake': intake,
      'status': status,
    };
  }

  // Keep this mutable for the mock student form we built
  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? program,
    String? intake,
    String? status,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      program: program ?? this.program,
      intake: intake ?? this.intake,
      status: status ?? this.status,
    );
  }
}

// Global mock list for our simple screens to use
List<Student> mockStudents = [
  const Student(id: 'STU001', name: 'Nipuna Lakruwan', email: 'nipuna@bci.edu', program: 'BSc Computer Science', intake: '2024', status: 'Active'),
  const Student(id: 'STU002', name: 'Sarah Perera', email: 'sarah@bci.edu', program: 'BBA Business Admin', intake: '2024', status: 'Active'),
  const Student(id: 'STU003', name: 'Kamal Silva', email: 'kamal@bci.edu', program: 'BSc Software Eng', intake: '2023', status: 'Inactive'),
  const Student(id: 'STU004', name: 'Amal Fernando', email: 'amal@bci.edu', program: 'BSc Computer Science', intake: '2024', status: 'Active'),
];
