class Enrolment {
  final String studentId;
  final List<String> courseIds;

  const Enrolment({
    required this.studentId,
    required this.courseIds,
  });

  factory Enrolment.fromJson(Map<String, dynamic> json) {
    return Enrolment(
      studentId: json['studentId'],
      courseIds: List<String>.from(json['courseIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'courseIds': courseIds,
    };
  }

  Enrolment copyWith({
    String? studentId,
    List<String>? courseIds,
  }) {
    return Enrolment(
      studentId: studentId ?? this.studentId,
      courseIds: courseIds ?? this.courseIds,
    );
  }
}
