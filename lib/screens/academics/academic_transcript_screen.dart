import 'package:flutter/material.dart';
import '../../features/students/model/student.dart';
import '../../models/grade_record.dart';

class AcademicTranscriptScreen extends StatelessWidget {
  final Student student;

  const AcademicTranscriptScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final studentGrades = mockGrades.where((g) => g.studentId == student.id).toList();
    final double gpa = calculateGPA(student.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Transcript'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFF1E3A8A),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Text(student.name[0], style: const TextStyle(fontSize: 24, color: Color(0xFF1E3A8A))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('${student.id} • ${student.program}', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Text('GPA', style: TextStyle(color: Colors.white70)),
                        Text(gpa.toStringAsFixed(2), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Module Grades', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            if (studentGrades.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Center(child: Text('No grades recorded yet.', style: TextStyle(color: Colors.grey))),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: studentGrades.length,
                  itemBuilder: (context, index) {
                    final grade = studentGrades[index];
                    return ListTile(
                      title: Text(grade.moduleName),
                      subtitle: Text('${grade.moduleId} • ${grade.credits} Credits'),
                      trailing: CircleAvatar(
                        backgroundColor: grade.grade == 'F' ? Colors.red.shade100 : Colors.green.shade100,
                        child: Text(
                          grade.grade,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: grade.grade == 'F' ? Colors.red : Colors.green.shade800,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
