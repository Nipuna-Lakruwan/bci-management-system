import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/student_controller.dart';
import '../../../core/widgets/app_card.dart';

class StudentDetailScreen extends StatelessWidget {
  final String studentId;

  const StudentDetailScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
      ),
      body: Consumer<StudentController>(
        builder: (context, controller, child) {
          final student = controller.students.firstWhere(
            (s) => s.id == studentId,
            orElse: () => throw Exception('Student not found'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: student.status == 'Active' ? Colors.blue.shade100 : Colors.red.shade100,
                  child: Text(
                    student.name[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 40,
                      color: student.status == 'Active' ? Colors.blue.shade900 : Colors.red.shade900,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  student.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  student.id,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Academic Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ListTile(
                        title: const Text('Programme'),
                        subtitle: Text(student.program),
                        leading: const Icon(Icons.school),
                      ),
                      ListTile(
                        title: const Text('Intake'),
                        subtitle: Text(student.intake),
                        leading: const Icon(Icons.calendar_today),
                      ),
                      ListTile(
                        title: const Text('Status'),
                        subtitle: Text(student.status),
                        leading: Icon(
                          Icons.circle,
                          color: student.status == 'Active' ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Contact Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      ListTile(
                        title: const Text('Email'),
                        subtitle: Text(student.email),
                        leading: const Icon(Icons.email),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to Enrolled Courses view (Phase 5)
                  },
                  icon: const Icon(Icons.book),
                  label: const Text('View Enrolled Courses'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
