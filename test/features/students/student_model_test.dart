import 'package:flutter_test/flutter_test.dart';
import 'package:bci_management_system/features/students/model/student.dart';

void main() {
  group('Student Model Tests', () {
    test('Student serialization to JSON', () {
      final student = Student(
        id: 'STU-123',
        name: 'John Doe',
        email: 'john@example.com',
        program: 'BSc Computer Science',
        intake: '2023',
        status: 'Active',
      );

      final json = student.toJson();
      
      expect(json['id'], 'STU-123');
      expect(json['name'], 'John Doe');
      expect(json['program'], 'BSc Computer Science');
    });

    test('Student deserialization from JSON', () {
      final json = {
        'id': 'STU-456',
        'name': 'Jane Smith',
        'email': 'jane@example.com',
        'program': 'BSc Software Engineering',
        'intake': '2024',
        'status': 'Inactive',
      };

      final student = Student.fromJson(json);
      
      expect(student.id, 'STU-456');
      expect(student.name, 'Jane Smith');
      expect(student.status, 'Inactive');
    });
  });
}
