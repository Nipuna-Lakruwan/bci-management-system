import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/enrolment_controller.dart';
import '../../students/model/student.dart';
import 'enrolment_screen.dart';

class StudentCoursesScreen extends StatelessWidget {
  final Student student;

  const StudentCoursesScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrolled Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EnrolmentScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<EnrolmentController>(
        builder: (context, enrolmentController, child) {
          final enrolledCourseIds = enrolmentController.getEnrolledCourseIds(student.id);
          
          if (enrolledCourseIds.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.book_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No courses enrolled yet.', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EnrolmentScreen()),
                      );
                    },
                    child: const Text('Enrol Now'),
                  ),
                ],
              ),
            );
          }

          final enrolledCourses = enrolmentController.courses
              .where((c) => enrolledCourseIds.contains(c.id))
              .toList();

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('${student.id} • ${enrolledCourses.length} Courses Enrolled', style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: enrolledCourses.length,
                  itemBuilder: (context, index) {
                    final course = enrolledCourses[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                          child: const Icon(Icons.check_circle, color: Color(0xFFF59E0B)),
                        ),
                        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${course.id} • ${course.credits} Credits\nLecturer: ${course.lecturer}'),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EnrolmentScreen()),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
