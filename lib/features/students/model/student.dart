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
