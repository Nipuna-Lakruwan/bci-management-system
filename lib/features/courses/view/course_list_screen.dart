import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/course_controller.dart';
import '../../../core/widgets/confirm_dialog.dart';
import 'course_form_screen.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseController>().loadCourses();
    });
  }

  void _navigateToAddCourse() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CourseFormScreen()),
    );
  }

  void _navigateToEdit(String id) {
    final controller = context.read<CourseController>();
    final course = controller.courses.firstWhere((c) => c.id == id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseFormScreen(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Management'),
      ),
      body: Consumer<CourseController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.courses.isEmpty) {
            return const Center(child: Text('No courses found.'));
          }

          return RefreshIndicator(
            onRefresh: () => controller.loadCourses(),
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: controller.courses.length,
              itemBuilder: (context, index) {
                final course = controller.courses[index];
                return Dismissible(
                  key: Key(course.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (_) async {
                    return await ConfirmDialog.show(
                      context,
                      title: 'Delete Course',
                      content: 'Are you sure you want to delete this course?',
                    );
                  },
                  onDismissed: (_) {
                    controller.deleteCourse(course.id);
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
                        child: const Icon(Icons.book, color: Color(0xFF1E3A8A)),
                      ),
                      title: Text(
                        course.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('${course.id} • ${course.credits} Credits\nLecturer: ${course.lecturer}'),
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        onPressed: () => _navigateToEdit(course.id),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddCourse,
        child: const Icon(Icons.add),
      ),
    );
  }
}
