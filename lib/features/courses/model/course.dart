class Course {
  final String id;
  final String name;
  final int credits;
  final String lecturer;

  const Course({
    required this.id,
    required this.name,
    required this.credits,
    required this.lecturer,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      credits: json['credits'],
      lecturer: json['lecturer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'credits': credits,
      'lecturer': lecturer,
    };
  }

  Course copyWith({
    String? id,
    String? name,
    int? credits,
    String? lecturer,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      credits: credits ?? this.credits,
      lecturer: lecturer ?? this.lecturer,
    );
  }
}
