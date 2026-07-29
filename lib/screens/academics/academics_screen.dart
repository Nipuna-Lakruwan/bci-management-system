import 'package:flutter/material.dart';
import '../../models/course_module.dart';
import 'attendance_marking_screen.dart';

class AcademicsScreen extends StatelessWidget {
  const AcademicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Modules'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockModules.length,
        itemBuilder: (context, index) {
          final module = mockModules[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                child: const Icon(Icons.book, color: Color(0xFF1E3A8A)),
              ),
              title: Text(
                module.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('${module.id} • ${module.credits} Credits\nLecturer: ${module.lecturer}'),
              ),
              isThreeLine: true,
              trailing: FilledButton.icon(
                icon: const Icon(Icons.checklist),
                label: const Text('Attendance'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceMarkingScreen(module: module),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
