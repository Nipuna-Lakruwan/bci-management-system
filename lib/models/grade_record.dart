class GradeRecord {
  final String studentId;
  final String moduleId;
  final String moduleName;
  final String grade; // A, B, C, F
  final int credits;

  GradeRecord({
    required this.studentId,
    required this.moduleId,
    required this.moduleName,
    required this.grade,
    required this.credits,
  });

  double get gradePoint {
    switch (grade) {
      case 'A': return 4.0;
      case 'B': return 3.0;
      case 'C': return 2.0;
      default: return 0.0;
    }
  }
}

// Global mock list for MVP Transcripts
List<GradeRecord> mockGrades = [
  GradeRecord(studentId: 'ST-2023-001', moduleId: 'SE101', moduleName: 'Introduction to Programming', grade: 'A', credits: 4),
  GradeRecord(studentId: 'ST-2023-001', moduleId: 'MATH201', moduleName: 'Discrete Mathematics', grade: 'B', credits: 3),
  GradeRecord(studentId: 'ST-2023-002', moduleId: 'SE101', moduleName: 'Introduction to Programming', grade: 'C', credits: 4),
];

double calculateGPA(String studentId) {
  final studentGrades = mockGrades.where((g) => g.studentId == studentId).toList();
  if (studentGrades.isEmpty) return 0.0;

  double totalPoints = 0;
  int totalCredits = 0;

  for (final g in studentGrades) {
    totalPoints += (g.gradePoint * g.credits);
    totalCredits += g.credits;
  }

  return totalCredits > 0 ? (totalPoints / totalCredits) : 0.0;
}
