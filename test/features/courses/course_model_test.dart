import 'package:flutter_test/flutter_test.dart';
import 'package:bci_management_system/features/courses/model/course.dart';

void main() {
  group('Course Model Tests', () {
    test('Course serialization to JSON', () {
      final course = Course(
        id: 'CS101',
        name: 'Introduction to Programming',
        credits: 3,
        lecturer: 'Dr. Alan Turing',
      );

      final json = course.toJson();
      
      expect(json['id'], 'CS101');
      expect(json['name'], 'Introduction to Programming');
      expect(json['credits'], 3);
    });
  });
}
