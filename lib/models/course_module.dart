class CourseModule {
  final String id;
  final String name;
  final int credits;
  final String lecturer;

  const CourseModule({
    required this.id,
    required this.name,
    required this.credits,
    required this.lecturer,
  });
}

// Global mock list for MVP
List<CourseModule> mockModules = [
  const CourseModule(id: 'SE101', name: 'Introduction to Programming', credits: 4, lecturer: 'Dr. Amal Jayasinghe'),
  const CourseModule(id: 'SE102', name: 'Database Systems', credits: 3, lecturer: 'Mr. Nimal Fernando'),
  const CourseModule(id: 'MATH201', name: 'Discrete Mathematics', credits: 3, lecturer: 'Mrs. Sarah Perera'),
  const CourseModule(id: 'SE201', name: 'Object Oriented Design', credits: 4, lecturer: 'Dr. Amal Jayasinghe'),
];
