import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/student_controller.dart';
import '../../../core/widgets/search_field.dart';
import '../../../core/widgets/confirm_dialog.dart';
import 'student_form_screen.dart';
import 'student_detail_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  void initState() {
    super.initState();
    // Load students on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentController>().loadStudents();
    });
  }

  void _navigateToAddStudent() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentFormScreen()),
    );
  }

  void _navigateToDetail(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentDetailScreen(studentId: id)),
    );
  }

  void _navigateToEdit(String id) async {
    final controller = context.read<StudentController>();
    final student = controller.students.firstWhere((s) => s.id == id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StudentFormScreen(student: student)),
    );
  }

  void _confirmDelete(String id) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: 'Delete Student',
      content: 'Are you sure you want to delete this student?',
    );

    if (confirmed == true && mounted) {
      context.read<StudentController>().deleteStudent(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
      body: Column(
        children: [
          SearchField(
            hintText: 'Search by name or ID...',
            onChanged: (value) {
              context.read<StudentController>().search(value);
            },
          ),
          Expanded(
            child: Consumer<StudentController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.students.isEmpty) {
                  return const Center(child: Text('No students found.'));
                }

                return RefreshIndicator(
                  onRefresh: () => controller.loadStudents(),
                  child: ListView.builder(
                    itemCount: controller.students.length,
                    itemBuilder: (context, index) {
                      final student = controller.students[index];
                      return Dismissible(
                        key: Key(student.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (_) async {
                          final confirmed = await ConfirmDialog.show(
                            context,
                            title: 'Delete Student',
                            content: 'Are you sure you want to delete this student?',
                          );
                          return confirmed;
                        },
                        onDismissed: (_) {
                          controller.deleteStudent(student.id);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: ListTile(
                            isThreeLine: true,
                            onTap: () => _navigateToDetail(student.id),
                            leading: CircleAvatar(
                              backgroundColor: student.status == 'Active' ? Colors.blue.shade100 : Colors.red.shade100,
                              child: Text(
                                student.name[0].toUpperCase(),
                                style: TextStyle(
                                  color: student.status == 'Active' ? Colors.blue.shade900 : Colors.red.shade900,
                                ),
                              ),
                            ),
                            title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${student.id} • ${student.program}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.grey),
                              onPressed: () => _navigateToEdit(student.id),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
